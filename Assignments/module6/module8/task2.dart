import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("tasks.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create table
  Future _createDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
      )
    """);
  }

  Future<int> addTask(String title) async {
    final db = await instance.database;
    return await db.insert("tasks", {"title": title});
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;
    return await db.query("tasks");
  }


  Future<int> updateTask(int id, String newTitle) async {
    final db = await instance.database;
    return await db.update("tasks", {"title": newTitle},
        where: "id = ?", whereArgs: [id]);
  }


  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete("tasks", where: "id = ?", whereArgs: [id]);
  }
}


class TodoHomePage extends StatefulWidget {
  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final db = DatabaseHelper.instance;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final data = await db.getTasks();
    setState(() => tasks = data);
  }


  void addTask() async {
    if (_controller.text.isNotEmpty) {
      await db.addTask(_controller.text);
      _controller.clear();
      loadTasks();
    }
  }


  void editTask(int id, String oldTitle) {
    TextEditingController editController =
    TextEditingController(text: oldTitle);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await db.updateTask(id, editController.text);
              loadTasks();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }


  void deleteTask(int id) async {
    await db.deleteTask(id);
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite To-Do App"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Enter task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text("Add"),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final item = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(item["title"]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              editTask(item["id"], item["title"]),
                        ),
                        IconButton(
                          icon:
                          const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => deleteTask(item["id"]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
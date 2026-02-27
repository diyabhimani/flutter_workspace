import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ------------------- DATABASE HELPER -------------------
class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("notes.db");
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

  Future _createDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL
      )
    """);
  }

  Future<int> addNote(String content) async {
    final db = await instance.database;
    return await db.insert("notes", {"content": content});
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await instance.database;
    return await db.query("notes");
  }

  Future<int> updateNote(int id, String newContent) async {
    final db = await instance.database;
    return await db.update("notes", {"content": newContent},
        where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete("notes", where: "id = ?", whereArgs: [id]);
  }
}

// ------------------- UI -------------------
class NotesHomePage extends StatefulWidget {
  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  final db = NotesDatabase.instance;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final data = await db.getNotes();
    setState(() => notes = data);
  }

  // Add new note
  void addNote() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Note"),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Write your note...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await db.addNote(controller.text);
                loadNotes();
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  // Edit existing note
  void editNote(int id, String oldContent) {
    TextEditingController controller = TextEditingController(text: oldContent);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Note"),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await db.updateNote(id, controller.text);
              loadNotes();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  void deleteNote(int id) async {
    await db.deleteNote(id);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App (SQLite)"),
        backgroundColor: Colors.orange,
      ),
      body: notes.isEmpty
          ? const Center(
        child: Text("No notes yet. Tap + to add."),
      )
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final item = notes[index];

          return Card(
            child: ListTile(
              title: Text(item["content"]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        editNote(item["id"], item["content"]),
                  ),
                  // Delete
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteNote(item["id"]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
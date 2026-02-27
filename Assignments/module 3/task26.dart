import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InfiniteScrollExample(),
    );
  }
}

class InfiniteScrollExample extends StatefulWidget {
  @override
  _InfiniteScrollExampleState createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<InfiniteScrollExample> {
  List<int> items = List.generate(20, (index) => index); // initial 20 items
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2)); 

      List<int> newItems =
      List.generate(20, (index) => items.length + index);

      setState(() {
        items.addAll(newItems);
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite Scrolling List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index == items.length) {
                  
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text("Scroll to load more"),
                    ),
                  );
                }

                return ListTile(
                  title: Text("Item ${items[index]}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

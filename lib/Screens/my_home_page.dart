import 'package:flutter/material.dart';
import 'package:todo_app/helper/database_helper.dart';
import 'package:todo_app/model/todo_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  List<TodoModel> todo = [];

  @override
  void initState() {
    getTodo();
    super.initState();
  }

  Future<void> getTodo() async {
    final data = await DatabaseHelper.getTodo();
    setState(() {
      todo = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100.withAlpha(75),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(16),

        child: Column(
          spacing: 12,
          children: [
            TextFormField(
              controller: title,

              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: .circular(12)),
                hintText: 'title',
              ),
            ),
            TextFormField(
              controller: description,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: .circular(12)),
                hintText: 'desc',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var valueTodo = TodoModel(
                  title: title.text.trim(),
                  description: description.text.trim(),
                );
                await DatabaseHelper.insertToDo(valueTodo);
                getTodo();
                description.clear();
                title.clear();
              },
              child: Text('Save'),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: todo.length,
              itemBuilder: (BuildContext context, int index) {
                var todos = todo[index];
                return ListTile(
                  leading: Text(todos.id.toString()),
                  title: Text(todos.title),
                  subtitle: Text(todos.description),
                  trailing: IconButton(
                    onPressed: () async {
                      DatabaseHelper.deltTode(todos.id!);
                      getTodo();
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

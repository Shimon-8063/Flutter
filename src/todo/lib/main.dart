import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _tasks.add({'title': title, 'done': false});
    });
    _controller.clear();
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOリスト'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _addTask,
                    decoration: InputDecoration(
                      hintText: 'タスクを入力...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTask(_controller.text),
                  child: Text('追加'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? Center(child: Text('タスクがありません'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (_) => _deleteTask(index),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task['done'],
                            onChanged: (_) => _toggleTask(index),
                          ),
                          title: Text(
                            task['title'],
                            style: TextStyle(
                              decoration: task['done']
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

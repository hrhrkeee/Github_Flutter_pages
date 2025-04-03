import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // TODOリストを保持するリスト
  List<String> _todos = [];
  // テキスト入力用のコントローラー
  final TextEditingController _controller = TextEditingController();

  // 新しいタスクを追加する関数
  void _addTodo() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(text);
      });
      _controller.clear();
    }
  }

  // 指定したタスクを削除する関数
  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODOアプリ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // タスク追加用の入力フォームとボタン
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'タスクを入力してください'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: _addTodo, child: Text('追加')),
              ],
            ),
            SizedBox(height: 16),
            // タスク一覧の表示
            Expanded(
              child:
                  _todos.isEmpty
                      ? Center(child: Text('タスクがありません'))
                      : ListView.builder(
                        itemCount: _todos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_todos[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _removeTodo(index),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

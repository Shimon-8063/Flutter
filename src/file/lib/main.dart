import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() => runApp(FileSaveApp());

class FileSaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FileSavePage(),
    );
  }
}

class FileSavePage extends StatefulWidget {
  @override
  _FileSavePageState createState() => _FileSavePageState();
}

class _FileSavePageState extends State<FileSavePage> {
  TextEditingController _controller = TextEditingController();
  String _status = '';

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _saveToFile(String content) async {
    final path = await _getLocalPath();
    final file = File('$path/mydata.txt');
    await file.writeAsString(content);
    setState(() {
      _status = '保存しました: ${file.path}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ファイル保存デモ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '保存したいテキスト'),
            ),
            ElevatedButton(
              onPressed: () => _saveToFile(_controller.text),
              child: Text('保存'),
            ),
            Text(_status),
          ],
        ),
      ),
    );
  }
}

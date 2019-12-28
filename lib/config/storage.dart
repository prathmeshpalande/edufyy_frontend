import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FilesHelper {
  String _fileName;

  FilesHelper(String fileName) {
    _fileName = fileName;
  }

  Future<String> get _rootDir async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _rootDir;
    return File('$path/$_fileName');
  }

  Future<bool> writeContent(String content) async {
    final file = await _localFile;
    File f = await file.writeAsString(content);
    return f.exists();
  }

  Future<String> readContent() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  }
}

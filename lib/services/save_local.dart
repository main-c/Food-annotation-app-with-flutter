import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  Storage({required this.fileName, required this.data});

  String fileName;
  String data;

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    print(directory!.path);
      return directory.path;
    }

    Future<File> get _localFile async {
      final path = await _localPath;
      return File('$path/$fileName');
    }

    Future<File> write() async {
      final file = await _localFile;
      return file.writeAsString(data);
  }
}

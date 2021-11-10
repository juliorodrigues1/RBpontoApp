import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:RBPONTOAMAC/model/employ.dart' as employ_global;

class Pdf {
  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File> loadNetwork(String url) async {
    var convert = Uri.parse(url);
    final response =
        await http.post(convert, body: {'employ_id': employ_global.employ_id});
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }
}

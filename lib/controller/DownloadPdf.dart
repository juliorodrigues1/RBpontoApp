// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';

// class Download{
//  var urlDownload = " ";
//  bool downloading = true;
//  String downString = "no data";
//  File f;
//  double download = 0.0;
//
//  Dio dio= new Dio();
//  var dir = await getApplicationDocumentsDirectory();
//  f = File("${dir.path}/myimagepath.jpg");
//  String fileName = imageUrl.substring(imageUrl.lastIndexOf("/")+1);
//  dio.download(imageUrl, "${dir.path}/$fileName",onReceiveProgress: (rec,total){
//  setState(() {
//  downloading=true;
//  download=(rec/total)*100;
//  print(fileName);
//  downloadingStr="Downloading Image : "+ (download).toStringAsFixed(0);
//   }
//     );
//
//  }
// }
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';

class Download {
  static var httpClient = new HttpClient();

  Future<File> _downloadFile (String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = 'Downloads';
  String myUrl = PreferencesKeys.homologadesmonstrativo;

  try {
    myUrl = url + '/' + fileName;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else
      filePath = ' Error' + response.statusCode.toString();
  } catch (ex) {
    filePath = 'Url não encontrada';
  }

  return filePath;
}

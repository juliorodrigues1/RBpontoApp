import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';




class Download{
 var urlDownload = " ";
 bool downloading = true;
 String downString = "no data";
 File f;
 double download = 0.0;

 Dio dio= Dio();
 var dir = await getApplicationDocumentsDirectory();
 f = File("${dir.path}/myimagepath.jpg");
 String fileName = imageUrl.substring(imageUrl.lastIndexOf("/")+1);
 dio.download(imageUrl, "${dir.path}/$fileName",onReceiveProgress: (rec,total){
 setState(() {
 downloading=true;
 download=(rec/total)*100;
 print(fileName);
 downloadingStr="Downloading Image : "+ (download).toStringAsFixed(0);
 });


}
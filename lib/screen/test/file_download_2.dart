import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class DownloadFile extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return _DownloadFileState();
  }

}

class _DownloadFileState extends State
{
  var  imageUrl="https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
  bool downloading=true;
  String downloadingStr="No data";
  double download=0.0;
  late File f;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadFile();
  }

  Future downloadFile() async
  {
    try{

      Dio dio=Dio();
      var dir=await getApplicationDocumentsDirectory();
      f=File("${dir.path}/myimagepath.jpg");
      String fileName=imageUrl.substring(imageUrl.lastIndexOf("/")+1);
      dio.download(imageUrl, "${dir.path}/$fileName",onReceiveProgress: (rec,total){
        setState(() {
          downloading=true;
          download=(rec/total)*100;
          downloadingStr="Downloading Image : "+(download).toStringAsFixed(0);
        });


        setState(() {
          downloading=false;
          downloadingStr="Completed";

        });

      });
    }catch( e)
    {
      print(e);
    }


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      home: Scaffold(
        appBar: AppBar(title: Text("Download File"),backgroundColor: Colors.pink,),
        body: Center(
          child: downloading?Container(
            height: 250,
            width: 250,
            child: Card(
              color: Colors.pink,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(backgroundColor: Colors.white,),

                  SizedBox(height: 20,),
                  Text(downloadingStr,style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ):Container(
            child: Center(
              child: Image.file(f,height: 200,fit: BoxFit.cover,),
            ),
          ),
        ),
      ),
    );
  }

}
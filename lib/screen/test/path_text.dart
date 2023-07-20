import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PathText extends StatefulWidget {
  const PathText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PathTextState createState() => _PathTextState();
}

class _PathTextState extends State<PathText> {
  final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  bool downloading = false;
  var progressString = "";

  @override
  void initState() {
    downloadFile();

    super.initState();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(imgUrl, "${dir.path}/myimage.jpg");
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: Center(
        child: downloading
            ? Container(
                height: 120.0,
                width: 200.0,
                child: Card(
                    color: Colors.black,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 20.0),
                      Text("Downloading File: $progressString",
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ])),
              )
            : Text("No Data"),
      ),
    );
  }
}

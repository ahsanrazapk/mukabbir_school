import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/custom_button.dart';
import 'package:mukabbir_schools/components/diary_worksheet_item.dart';
import 'package:mukabbir_schools/model/workbook_model.dart';
import 'package:mukabbir_schools/screen/test/path_text.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:mukabbir_schools/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WorkbookScreen extends StatefulWidget {
  @override
  _WorkbookScreenState createState() => _WorkbookScreenState();
}

class _WorkbookScreenState extends State<WorkbookScreen> {
  late String dropdownValue;

  late WorkBookModel _workBookModel;
  bool isLoading = true;
  late String tokenValue;

  //common document directory path to download and save workbook pdf file

  late Directory appDocDir;
  late String appDocPath;

  String _fileUrl = "";
  final String _fileName = "workbook_1.pdf";
  String _progress = "-";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final Dio _dfinalio = Dio();

  var dio = Dio();
  static var httpClient = new HttpClient();

  @override
  void initState() {
    dropdownValue = DateFormat('EEEE').format(DateTime.now());
    print('current weekday: ${dropdownValue.toString()}');

    _getToken().then((value) {
      ///temporarily commented, uncomment it later
      //tokenValue = value;
      tokenValue =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcG9ydGFsLm11a2FiYmlyc2Nob29scy5lZHUucGtcL2FwaVwvbG9naW4iLCJpYXQiOjE2MjQ5NzU1MDgsIm5iZiI6MTYyNDk3NTUwOCwianRpIjoicVRKZ21XTzY4dXFMUDRYbiIsInN1YiI6MjM2MywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.2IdBay83maIpKubJbGeUO2JsuNe2BM3frpqjtLIQK3U';

      _fetchWorkbook(value, 'Tuesday').then((res) => {
            _workBookModel = res,
          });
    });

    _getDocDirectoryPathForFile();
    _requestPermissions();

    super.initState();
  }

  Future<String> _getToken() async {
    String tokenValue = await SharedPref.read(AppConstants.token);
    return tokenValue;
  }

  _getDocDirectoryPathForFile() async {
    appDocDir = await getApplicationDocumentsDirectory();

    /*bool hasExisted = await appDocDir.exists();
    if(hasExisted) {
      print('path did not exists ${appDocDir}');
    }
    else {
      appDocDir.create();
      print('path created ${appDocDir.path}');
    }*/

    appDocPath = appDocDir.path;
  }

  _requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
    }
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            //BgImageContainer(image: AppConstants.defaultBg),

            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/top_circle.png',
                  width: MediaQuery.of(context).size.width * 0.8, height: 70),
            ),

            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/mukabbir_logo.png', width: 90, height: 90),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/pencils.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),

            if (isLoading)
              Utils.loadingWidget()
            else
              Padding(
                padding: EdgeInsets.all(
                  16.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //back arrow
                      BackWidget(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),

                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          primary: true,
                          children: [
                            _daysDropdown(context),
                            SizedBox(
                              height: 16,
                            ),
                            Center(child: Text(AppStrings.diaryWorksheet, style: headingTextStyle)),
                            SizedBox(
                              height: 16,
                            ),
                            _workBookModel.worksheet.length != 0
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7, bottom: 12, top: 10),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width / 3,
                                                child: Text('Subjects', style: headingNormalTextStyle)),
                                            Text('Description', style: headingNormalTextStyle),
                                          ],
                                        ),
                                      ),
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        itemCount: _workBookModel.worksheet[0].subjectsDetail.length,
                                        shrinkWrap: true,
                                        primary: false,
                                        separatorBuilder: (context, i) {
                                          return Divider(
                                            thickness: 2,
                                          );
                                        },
                                        itemBuilder: (BuildContext context, int index) {
                                          return DiaryWorksheetItem(
                                              item: _workBookModel.worksheet[0].subjectsDetail[index],
                                              date: _workBookModel.worksheet[0].date);
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(AppStrings.fileHeading,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      _getPdfIcon(context),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      _workBookModel.worksheet[0].fileExist == 1
                                          ? Column(
                                              children: [
                                                CustomButton(
                                                  text: AppStrings.downloadFileButtonText.toUpperCase(),
                                                  callback: () async {
                                                    //download workbook pdf file
                                                    Utils.downloadFile(_workBookModel.worksheet[0].file,
                                                        _workBookModel.worksheet[0].file.split('/').last, appDocPath);

                                                    final taskId = await FlutterDownloader.enqueue(
                                                      url: _workBookModel.worksheet[0].file,
                                                      savedDir: '$appDocPath/test.pdf',
                                                      showNotification:
                                                          true, // show download progress in status bar (for Android)
                                                      openFileFromNotification:
                                                          true, // click on notification to open downloaded file (for Android)
                                                    );

                                                    // String fullPath = tempDir.path + "/boo2.pdf'";
                                                    String fullPath = "$appDocPath/test.pdf";
                                                    print('full path ${fullPath}');

                                                    download2(dio, _workBookModel.worksheet[0].file, fullPath);

                                                    _downloadFile(_workBookModel.worksheet[0].file,
                                                        _workBookModel.worksheet[0].file.split('/').last);

                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => PathText(
                                                          title: '',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            )
                                          : Utils.noDataWidget(context, AppStrings.noFileUploaded),
                                    ],
                                  )
                                : Utils.noDataWidget(context, AppStrings.noDataUploaded),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Widget _getPdfIcon(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.asset(AppConstants.pdfIcon,
              width: MediaQuery.of(context).size.width * 0.38, height: MediaQuery.of(context).size.height * 0.14),
        ),
      ),
    );
  }

  Widget _daysDropdown(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(
          12.0,
        )),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
        ),
        onChanged: (String? newValue) {
          setState(() {
            isLoading = true;
            dropdownValue = newValue!;
          });

          _fetchWorkbook(tokenValue, dropdownValue).then((res) => {
                setState(() {
                  _workBookModel = res;
                }),
              });
        },
        items: <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<WorkBookModel> _fetchWorkbook(String token, String weekday) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseURL}/student-dairy-worksheet'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'day': weekday,
      },
    );

    print('workbook response: ${response.body}');

    if (response.body.contains('false')) {
      setState(() {
        isLoading = false;
      });

      return WorkBookModel(status: 200, type: false, worksheet: [], message: 'Data not found');
    }

    print('request: ${response.request?.headers.toString()}');
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      return WorkBookModel.fromJson(jsonDecode(response.body));
    } else {
      setState(() {
        isLoading = false;
      });

      throw Exception('Failed to load workbook data ${response.body}');
    }
  }
}

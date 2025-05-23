import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/model/result/result_card.dart';
import 'package:mukabbir_schools/model/result/result_model.dart';
import 'package:mukabbir_schools/screen/result_attendance_notification/res_att_pages/terms_list_model.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/utils.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  TermListModel dropdownValue = termsList[0];

  ResultModel? _studentResult;

  bool isLoading = true;

  double grandTotalMarks = 0.0;
  double totalMarksObtained = 0.0;
  double percentage = 0.0;
  late String resultStatus;
  late int termValue;
  late String tokenValue;

  int count = 0;

  @override
  void initState() {
    _getToken().then((value) {
      tokenValue = value;
      _fetchStudentResult(value, dropdownValue.key).then((res) => {
            _studentResultsResponseCheck(res),
          });
    });

    super.initState();
  }

  Future<String> _getToken() async {
    String tokenValue = await SharedPref.read(AppConstants.token);
    return tokenValue;
  }

  _studentResultsResponseCheck(ResultModel result) {
    setState(() {
      _studentResult = result;
      _getTotalMarks();
      _getTotalMarksObtained();
      _getPercentage();
      _getResultStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            //BgImageContainer(image: AppConstants.studentProfile),

            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/top_circle.png', width: MediaQuery.of(context).size.width * 0.8, height: 70),
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

            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/bottom_circle.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.14,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //back arrow
                      BackWidget(),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          primary: true,
                          children: [
                            Text(AppStrings.selectYourTerm, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                            SizedBox(
                              height: 16,
                            ),

                            //terms dropdown
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: DropdownButton<TermListModel>(
                                isExpanded: true,
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                underline: Container(height: 2),
                                onChanged: (TermListModel? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    isLoading = true;
                                  });
                                  /*List<String> term = [];
                                  if (dropdownValue.key == '11') {
                                   */ /* term.add('15');
                                    term.add('16');*/ /*
                                    term.add('11');
                                  } else if (dropdownValue.key == '12') {
                                    term.add('17');
                                    term.add('18');
                                    term.add('12');
                                  } else if (dropdownValue.key == '14') {
                                    term.add('19');
                                    term.add('20');
                                    term.add('14');
                                  } else {
                                    term.add(dropdownValue.key);
                                  }*/
                                  _fetchStudentResult(tokenValue, dropdownValue.key).then((res) => {
                                        _studentResultsResponseCheck(
                                          res,
                                        )
                                      });
                                },
                                items: termsList.map<DropdownMenuItem<TermListModel>>(
                                  (TermListModel value) {
                                    return DropdownMenuItem<TermListModel>(
                                        value: value,
                                        child: Text(
                                          value.value,
                                        ));
                                  },
                                ).toList(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            _studentResult?.type ?? false
                                ? Column(
                                    children: [
                                      _resultTableHeadings(),

                                      SizedBox(height: 16.0),

                                      //subject results list view
                                      /*ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: _studentResult?.resultCard?.length,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: (BuildContext context, int index) {
                                          String? title;
                                          termsList.forEach((element) {
                                            if (element.key ==
                                                _studentResult?.resultCard[index].term.toString()) {
                                              title = element.value;
                                              return;
                                            }
                                          });
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (index == 0 ||
                                                    _studentResult?.resultCard.resultDetail[index].term !=
                                                        _studentResult?.resultCard.resultDetail[index - 1].term)
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 20),
                                                    child: Text(title!,
                                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                  ),
                                                SizedBox(height: 15),
                                                Container(
                                                    color: Colors.orange,
                                                    padding: EdgeInsets.all(12.0),
                                                    child: Row(children: [
                                                      Expanded(
                                                        child: Text(
                                                            _studentResult?.resultCard.resultDetail[index].subjectName ?? '',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.normal,
                                                                color: Colors.white)),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                            padding: EdgeInsets.only(left: 16.0),
                                                            child: Text(
                                                                _studentResult?.resultCard.resultDetail[index].totalMarks
                                                                    .toString() ?? '',
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: Colors.white))),
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                              padding: EdgeInsets.only(left: 16.0),
                                                              child: Text(
                                                                _studentResult
                                                                    ?.resultCard.resultDetail[index].obtainMarks
                                                                    .toString() ?? '',
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: Colors.white),
                                                              )))
                                                    ]))
                                              ],
                                            ),
                                          );
                                        },
                                      ),*/

                                      SizedBox(height: 8.0),

                                      Image.asset('assets/images/pencil.png', width: 120, height: 40),

                                      SizedBox(height: 8.0),

                                      //overall progress headings row
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  padding: const EdgeInsets.all(6.0),
                                                  decoration:
                                                      BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(4.0))),
                                                  child: Center(
                                                    child: Text(
                                                      "Marks",
                                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(width: 16.0),
                                            Expanded(
                                              child: Container(
                                                  padding: const EdgeInsets.all(6.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(4.0),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      "Percentage",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(width: 16.0),
                                            Expanded(
                                              child: Container(
                                                  padding: const EdgeInsets.all(6.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(4.0),
                                                      )),
                                                  child: Center(
                                                    child: Text("Status",
                                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white)),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 8.0),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  height: 90,
                                                  padding: const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.orange),
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                  ),
                                                  child: Center(
                                                      child: Text("${totalMarksObtained.toInt()} / ${grandTotalMarks.toInt()}",
                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange)))),
                                            ),
                                            SizedBox(width: 16.0),
                                            Expanded(
                                              child: Container(
                                                  height: 90,
                                                  padding: const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.orange),
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${percentage.toStringAsFixed(1)} %',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(width: 16.0),
                                            Expanded(
                                              child: Container(
                                                  height: 90,
                                                  padding: const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.orange),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(8.0),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      resultStatus,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 16.0),
                                    ],
                                  )
                                : Utils.noDataWidget(context, AppStrings.noResults),
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

  Row _resultTableHeadings() {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Subject',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange),
              )),
            ),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Total Marks',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange),
              )),
            ),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Obt. Marks',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange),
              )),
            ),
          ),
        ),
      ],
    );
  }

  _getPercentage() {
    percentage = 0.0;
    percentage = ((totalMarksObtained / grandTotalMarks) * 100);
  }

  _getResultStatus() {
    if (percentage >= 50)
      resultStatus = 'Passed';
    else
      resultStatus = 'Failed';
  }

  _getTotalMarks() {
    grandTotalMarks = 0.0;
    int length = _studentResult?.resultCard?.length ?? 0;
    for (int i = 0; i < length; i++) {
      grandTotalMarks += _studentResult?.resultCard![i].totalMarks?.toDouble() ?? 0;
    }
    if(dropdownValue.key == '11' || dropdownValue.key == '12' || dropdownValue.key == '14'){
      grandTotalMarks *= 3;
    }
  }

  _getTotalMarksObtained() {
    totalMarksObtained = 0.0;
    int length = _studentResult?.resultCard?.length ?? 0;
    for (int i = 0; i < length; i++) {
      if (dropdownValue.key == '11') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i11?.marks ?? 0.0) +
            (_studentResult?.resultCard?[i].obtainedMarks?.i15?.marks ?? 0.0) +
            ((_studentResult?.resultCard?[i].obtainedMarks?.i16?.marks ?? 0.0)));
      } else if (dropdownValue.key == '12') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i12?.marks ?? 0.0) +
            (_studentResult?.resultCard?[i].obtainedMarks?.i17?.marks ?? 0.0) +
            ((_studentResult?.resultCard?[i].obtainedMarks?.i18?.marks ?? 0.0)));
      } else if (dropdownValue.key == '14') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i14?.marks ?? 0.0) +
            (_studentResult?.resultCard?[i].obtainedMarks?.i19?.marks ?? 0.0) +
            ((_studentResult?.resultCard?[i].obtainedMarks?.i20?.marks ?? 0.0)));
      } else if (dropdownValue.key == '15') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i15?.marks ?? 0.0));
      } else if (dropdownValue.key == '16') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i16?.marks ?? 0.0));
      } else if (dropdownValue.key == '17') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i17?.marks ?? 0.0));
      } else if (dropdownValue.key == '18') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i18?.marks ?? 0.0));
      } else if (dropdownValue.key == '19') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i19?.marks ?? 0.0));
      } else if (dropdownValue.key == '20') {
        totalMarksObtained += ((_studentResult?.resultCard?[i].obtainedMarks?.i20?.marks ?? 0.0));
      }
    }
    print(totalMarksObtained);
  }

  Future<ResultModel> _fetchStudentResult(String token, String data) async {
    print(data);
    print('sending token: $token');
    final response = await http.post(Uri.parse('${AppConstants.baseURL}/student-resultcard'),
        headers: {'Authorization': 'Bearer $token', HttpHeaders.contentTypeHeader: 'application/json'}, body: json.encode({"term": data}));

    print(response.statusCode);

    if (response.body.contains('false')) {
      setState(() {
        isLoading = false;
      });

      return ResultModel(status: 200, type: false, resultCard: null, message: 'Data not found');
    }

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      print('student result response: ${jsonDecode(response.body)}');
      ResultModel result = ResultModel.fromJson(jsonDecode(response.body));
      return result;
    } else {
      setState(() => isLoading = false);

      throw Exception('Failed to load student result data ${response.body}');
    }
  }
}

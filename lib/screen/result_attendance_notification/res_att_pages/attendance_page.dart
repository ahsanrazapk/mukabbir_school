import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/bg_image_container.dart';
import 'package:mukabbir_schools/model/attendance/attendance_model.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:mukabbir_schools/utils/utils.dart';



class AttendancePage extends StatefulWidget {

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  DateTime _currentDate = DateTime.now();
  late DateTime startCalendarDate;

  double circleSize = 16.0;
  double markedDateCircleSize = 6.0;

  late AttendanceModel _attendanceModel;
  bool isLoading = true;
  late String tokenValue;

  //attendance response code
  //0 is for absent
  //1 is for present
  //2 is fo leave


  @override
  void initState() {

    DateTime date = DateTime.now();
    startCalendarDate = date.subtract(Duration(days: 1));

    _getToken().then((value) {

      ///temporarily commented, uncomment it later
      //tokenValue = value;
      tokenValue = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcG9ydGFsLm11a2FiYmlyc2Nob29scy5lZHUucGtcL2FwaVwvbG9naW4iLCJpYXQiOjE2MjQ5NzU1MDgsIm5iZiI6MTYyNDk3NTUwOCwianRpIjoicVRKZ21XTzY4dXFMUDRYbiIsInN1YiI6MjM2MywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.2IdBay83maIpKubJbGeUO2JsuNe2BM3frpqjtLIQK3U';

      _fetchAttendance(value, '06').then((res) => {
        _attendanceModel = res,

      }).then((value) => {
        _addAttendanceOnCalendar(),
      });


    });


    super.initState();
  }

  Future<String> _getToken() async {
    String tokenValue = await SharedPref.read(AppConstants.token);
    return tokenValue;
  }

  EventList<Event> _markedDateMap = new EventList<Event>(events: {});

  _addAttendanceOnCalendar() {

    for(int i=0; i<_attendanceModel.attendance.length; i++) {
      DateTime dt = Utils.convertDateFromString(_attendanceModel.attendance[i].attendanceDate);
      _markedDateMap.add(
          dt,
          new Event(
            date: dt,
            dot: Container(
              decoration: BoxDecoration(
                  color: _getAttendanceColor(_attendanceModel.attendance[i].attendanceStatus),
                  shape: BoxShape.circle
              ),
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              height: markedDateCircleSize,
              width: markedDateCircleSize,
            ),
          )
      );
    }

  }

  Color _getAttendanceColor(String attendanceStatus) {
    if(attendanceStatus == '0') {
      return Colors.red;
    }
    else if(attendanceStatus == '1') {
      return Colors.green;
    }
    else if(attendanceStatus == '2') {
      return Colors.yellow;
    }

    return Colors.green;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [

            //BgImageContainer(image: AppConstants.attendanceBg),

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
              bottom: -20,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/attendance_bottom_bg.jpg', width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,),
            ),


            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [

                  //back arrow
                  BackWidget(),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  _displayCalendar(),

                  _attendanceStatusRow(),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }


  Widget _displayCalendar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      //color: Colors.blue,
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {

        },
        weekendTextStyle: TextStyle(
          color: Colors.black,
        ),
        thisMonthDayBorderColor: Colors.white,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        //minSelectedDate: DateTime.now(),
        //minSelectedDate: startCalendarDate,
        weekdayTextStyle: TextStyle(color: Colors.black),
        weekFormat: false,
        height: MediaQuery.of(context).size.height * 0.42,
        selectedDateTime: _currentDate,
        todayButtonColor: ColorConstants.whiteColor,
        todayTextStyle: TextStyle(color: Colors.black,),
        todayBorderColor: Colors.grey,
        selectedDayBorderColor: ColorConstants.primaryColor,
        selectedDayButtonColor: ColorConstants.primaryColor,
        daysHaveCircularBorder: false,
        markedDatesMap: _markedDateMap,
        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget _attendanceStatusRow() {
    return SizedBox(
      height: 42,
      child: Row(
        children: [

          Expanded(
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle
                      ),
                    ),

                    SizedBox(width: 6),

                    Container(
                      width: 1.0,
                      height: double.maxFinite,
                      color: Colors.black,
                    ),

                    SizedBox(width: 6),

                    Expanded(
                      child: Text('Preset', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.green),
                        overflow: TextOverflow.ellipsis, maxLines: 1,),
                    ),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.0,),
          Expanded(
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle
                      ),
                    ),

                    SizedBox(width: 6),

                    Container(
                      width: 1.0,
                      height: double.maxFinite,
                      color: Colors.black,
                    ),

                    SizedBox(width: 6),

                    Expanded(
                      child: Text('Leave', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.yellow),
                        overflow: TextOverflow.ellipsis, maxLines: 1,),
                    ),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.0,),
          Expanded(
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: 1.0,
                      height: double.maxFinite,
                      color: Colors.black,
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text('Absent', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.red),
                        overflow: TextOverflow.ellipsis, maxLines: 1,),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<AttendanceModel> _fetchAttendance(String token, String month) async {

    final response = await http.post(
        Uri.parse('${AppConstants.baseURL}/student-attendance'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'month': '06',
        }
    );

    print('attendance response: ${response.body}');

    if(response.body.contains('false')) {

      setState(() {
        isLoading = false;
      });

      //return AttendanceModel(status: 200, type: false, worksheet: [], message: 'Data not found');
    }

    print('request: ${response.request?.headers.toString()}');
    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        isLoading = false;
      });

      return AttendanceModel.fromJson(jsonDecode(response.body));
    } else {

      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        isLoading = false;
      });

      throw Exception('Failed to fetch attendance data ${response.body}');
    }
  }



}


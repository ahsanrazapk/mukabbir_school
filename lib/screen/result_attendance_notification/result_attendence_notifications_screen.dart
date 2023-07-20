import 'package:flutter/material.dart';
import 'package:mukabbir_schools/screen/result_attendance_notification/res_att_pages/attendance_page.dart';
import 'package:mukabbir_schools/screen/result_attendance_notification/res_att_pages/new_notifications_page.dart';
import 'package:mukabbir_schools/screen/result_attendance_notification/res_att_pages/notifications_page.dart';
import 'package:mukabbir_schools/screen/result_attendance_notification/res_att_pages/result_page.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';

class ResultAttendanceNotificationsScreen extends StatefulWidget {
  final int pageIndex;

  ResultAttendanceNotificationsScreen({required this.pageIndex});

  @override
  _ResultAttendanceNotificationsScreenState createState() => _ResultAttendanceNotificationsScreenState();
}

class _ResultAttendanceNotificationsScreenState extends State<ResultAttendanceNotificationsScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.pageIndex;

    super.initState();
  }

  static List<Widget> _pages = <Widget>[
    ResultPage(),
    ResultPage(),
    AttendancePage(),
    NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Result',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstants.blueColor,
        unselectedItemColor: ColorConstants.blueColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:mukabbir_schools/components/bg_image_container.dart';
import 'package:mukabbir_schools/components/custom_dialog.dart';
import 'package:mukabbir_schools/screen/fee/fee_screen.dart';
import 'package:mukabbir_schools/screen/gallery/gallery_screen.dart';
import 'package:mukabbir_schools/screen/login/login_screen.dart';
import 'package:mukabbir_schools/screen/profile/profile_screen.dart';
import 'package:mukabbir_schools/screen/result_attendance_notification/result_attendence_notifications_screen.dart';
import 'package:mukabbir_schools/screen/workbook/workbook_screen.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:mukabbir_schools/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [

            //BgImageContainer(image: AppConstants.homeBg),

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
              child: Image.asset('assets/images/home_bottom_img.jpg', width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.41, fit: BoxFit.cover,),
            ),
            
            Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  Text(AppStrings.studentDashboardText,
                      style: headingTextStyle),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstants.blueColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Center(
                          child: Text(
                            Utils.profileModel.profileDetail.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.whiteColor,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [

                        //first row
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultAttendanceNotificationsScreen(pageIndex: 1),
                                    ),
                                  );

                                },
                                //child: Image.asset('assets/images/results.png'),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [

                                    Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Color(0xFFFFBB00),
                                                Color(0xFFFF8500),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(60.0),
                                            )
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text('Results', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white,),),
                                            ),
                                          ],
                                        )
                                    ),

                                    Image.asset('assets/images/circle_result.png', width: 56, height: 56,),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 8.0),

                            Expanded(
                              child: InkWell(
                                onTap: () {

                                  //navigate to attendance page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultAttendanceNotificationsScreen(pageIndex: 2),
                                    ),
                                  );

                                },
                                //child: Image.asset('assets/images/results.png'),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerStart,
                                  children: [

                                    Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Color(0xFF05C1A6),
                                                Color(0xFF30D6C1),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(60.0),
                                            )
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 48.0),
                                              child: Text('Attendance', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white,),),
                                            ),
                                          ],
                                        )
                                    ),

                                    Image.asset('assets/images/circle_attendance.png', width: 56, height: 56,),

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(
                          height: 8.0,
                        ),

                        //2nd row
                        Row(
                          children: [

                            Expanded(
                              child: InkWell(
                                onTap: () {

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FeeScreen(),
                                    ),
                                  );

                                },
                                //child: Image.asset('assets/images/results.png'),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [

                                    Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Color(0xFFC2177F),
                                                Color(0xFFF9269F),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(60.0),
                                            )
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text('Fee', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white,),),
                                            ),
                                          ],
                                        )
                                    ),

                                    Image.asset('assets/images/circle_fee.png', width: 56, height: 56,),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 8.0),

                            Expanded(
                              child: InkWell(
                                onTap: () {

                                  //navigate to workbook screen
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WorkbookScreen(),
                                    ),
                                  );

                                },
                                //child: Image.asset('assets/images/results.png'),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerStart,
                                  children: [

                                    Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Color(0xFF0E589B),
                                                Color(0xFF0287E4),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(60.0),
                                            )
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 48.0),
                                              child: Text('Workbook', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white,),),
                                            ),
                                          ],
                                        )
                                    ),

                                    Image.asset('assets/images/cirlce_workbook.png', width: 56, height: 56,),

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sign Out',
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

    if(index == 0) {

      //navigate to profile screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ProfileScreen(),
        ),
      );
    }
    else if(index == 1) {

      //navigate to gallery screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              GalleryScreen(),
        ),
      );

    }
    else if(index == 2) {

      //navigate to notifications page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ResultAttendanceNotificationsScreen(pageIndex: 3),
        ),
      );

    }
    else if(index == 3) {

      //display confirmation dialog
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'Logout?',
              message: 'Are you sure you want to Logout?',
              no: 'No',
              yes: 'Yes',
              noCallback: () {
                Navigator.pop(context);
              },
              yesCallback: () {

                //save token to shared preferences
                SharedPref.remove(AppConstants.token);

                Future.delayed(const Duration(milliseconds: 500), () {

                  //navigate to login screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(),
                    ),
                  );

                });

              },
            );
          }
      );



    }

  }

}

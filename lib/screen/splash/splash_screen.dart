import 'package:flutter/material.dart';
import 'package:mukabbir_schools/screen/login/login_screen.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';

import '../../utils/shared_prefs.dart';
import '../loading/loading_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    //SharedPref.remove(AppConstants.token);

    controller = AnimationController(duration: const Duration(milliseconds: 4000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        bool isExist = await SharedPref.checkIfKeyExistsInSharedPref(AppConstants.token);

        if (isExist) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoadingScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    //this will start the animation
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.center,
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
                  'assets/images/building_bg.jpg',
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

              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.18,
                    ),
                    child: FadeTransition(
                      opacity: animation,
                      child: Image.asset(
                        AppConstants.splashLogo,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

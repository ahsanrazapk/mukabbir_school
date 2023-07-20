import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:mukabbir_schools/model/login_error_response.dart';
import 'package:mukabbir_schools/model/login_response.dart';
import 'package:mukabbir_schools/screen/loading/loading_screen.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:mukabbir_schools/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController studentIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String studentIdValue;
  late String passwordValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ProgressHUD(
          child: Builder(
            builder: (cxt) => SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  //BgImageContainer(image: AppConstants.loginBg),

                  Column(
                    children: [
                      Image.asset('assets/images/top_circle.png',
                          width: MediaQuery.of(context).size.width * 0.8, height: 70),

                      Image.asset('assets/images/mukabbir_logo.png', width: 90, height: 90),
                      //add pencil bg here
                      const Spacer(),
                      Image.asset('assets/images/login_bottom_bg.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                          fit: BoxFit.cover),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.20,
                            ),
                            Text(AppStrings.studentLogin, style: headingTextStyle),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: studentIdController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: AppStrings.studentIdLabel,
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (studentId) {
                                      if (studentId == null || studentId.isEmpty) {
                                        return 'Student Id field empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: AppStrings.passwordLabel,
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (password) {
                                      if (password == null || password.isEmpty) {
                                        return 'Password field empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 48,
                              child: ElevatedButton(
                                child: Text(AppStrings.loginButtonText.toUpperCase()),
                                onPressed: () {
                                  print('Login Button Pressed');

                                  validateAndSave(cxt);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSave(BuildContext cxt) async {
    final form = formKey.currentState;

    if (form != null && form.validate()) {
      form.save();

      LoginResponse loginResponse =
          await getLoginApiCall(cxt, studentIdController.text, passwordController.text, AppConstants.fcm_token);

      if (loginResponse.type) {
        //save token to shared preferences
        await SharedPref.save(AppConstants.token, loginResponse.token);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoadingScreen(),
          ),
        );
      } else {
        print('invalid login credentials !');
        Utils.displayToast(loginResponse.message);
      }
    }
  }

  Future<LoginResponse> getLoginApiCall(BuildContext cxt, String username, String password, String fcmToken) async {
    print('sending fcm token: $fcmToken');

    final progress = ProgressHUD.of(cxt);
    progress?.showWithText('Loading...');

    final response = await http.post(Uri.parse('${AppConstants.baseURL}/login'),
        body: {"username": username, "password": password, 'fcm_token': fcmToken});

    if (response.statusCode == 200) {
      progress?.dismiss();
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      LoginErrorResponse loginErrorResponse = LoginErrorResponse.fromJson(jsonDecode(response.body));
      Utils.displayToast(loginErrorResponse.message);

      progress?.dismiss();
      throw Exception('Failed to login');
    }
  }

  @override
  void dispose() {
    studentIdController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}

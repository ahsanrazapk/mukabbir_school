import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/bg_image_container.dart';
import 'package:mukabbir_schools/model/update_password_response.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String passwordValue;
  late String confirmPasswordValue;

  late UpdatePasswordResponse updatePasswordResponse;
  bool isLoading = false;
  late String tokenValue;

  @override
  void initState() {

    _getToken().then((value) {
      print('token value: $value');
      setState(() {
        tokenValue = value;
      });
    });

    super.initState();
  }

  Future<String> _getToken() async {
    String tokenValue = await SharedPref.read(AppConstants.token);
    return tokenValue;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: ProgressHUD(
          child: Builder(
              builder: (cxt) => Stack(
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
                    child: Image.asset('assets/images/building_bg.jpg', width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,),
                  ),

                  Positioned(
                    bottom: -20,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/images/bottom_circle.png', width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.14, fit: BoxFit.cover,),
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [

                          //back
                          BackWidget(),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                          ),

                          Text(AppStrings.changePasswordHeading, style: headingTextStyle),

                          SizedBox(
                            height: 16,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [

                                TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
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

                                SizedBox(
                                  height: 16,
                                ),

                                TextFormField(
                                  controller: confirmPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: AppStrings.confirmPasswordLabel,
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (confirmPassword) {

                                    if (confirmPassword == null || confirmPassword.isEmpty) {
                                      return 'Confirm Password field empty';
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
                              child: Text(AppStrings.uploadPasswordButtonText.toUpperCase()),
                              onPressed: () {
                                print('Update Button Pressed');

                                validateAndSave(cxt);

                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),



                ],
              ),
          ),
        ),
      ),
    );
  }

  void validateAndSave(BuildContext cxt) {
    final form = formKey.currentState;

    if (form != null && form.validate()) {

      form.save();
      _updatePasswordApiCAll(cxt).then((value) => {
        _displayUpdatePasswordResponse(value),
      });

    }
  }

  Future<UpdatePasswordResponse> _updatePasswordApiCAll(BuildContext cxt) async {

    final progress = ProgressHUD.of(cxt);
    progress?.showWithText('Loading...');

    print('sending token: $tokenValue');
    final response = await http.post(
        Uri.parse('${AppConstants.baseURL}/update-password'),
        headers: {
          'Authorization': 'Bearer $tokenValue',
        },
        body: {
          'password': passwordController.text,
        },
    );


    print('request: ${response.request?.headers.toString()}');
    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        isLoading = false;
      });

      print('update password response: ${jsonDecode(response.body)}');
      progress?.dismiss();

      return UpdatePasswordResponse.fromJson(jsonDecode(response.body));
    } else {

      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        isLoading = false;
      });

      progress?.dismiss();
      throw Exception('Failed update password ${response.body}');
    }
  }

  _displayUpdatePasswordResponse(UpdatePasswordResponse value) {
    updatePasswordResponse = value;
    Utils.displayToast(updatePasswordResponse.message);
  }


  @override
  void dispose() {

    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }


}

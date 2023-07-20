import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mukabbir_schools/model/profile_model.dart';
import 'package:mukabbir_schools/screen/home/home_screen.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/utils.dart';


class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  //profile info
  bool isLoading = true;
  late String tokenValue;

  @override
  void initState() {

    _getToken().then((value) {

      _fetchProfileData(value).then((profile) => {

        if(profile.type) {

          setState(() {
            tokenValue = value;
            Utils.profileModel = profile;
          }),

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
            builder: (context) =>
            HomeScreen()),
          ),
        }

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
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<ProfileModel> _fetchProfileData(String token) async {

    final response = await http.get(
        Uri.parse('${AppConstants.baseURL}/student-profile-detail'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    print('request: ${response.request?.headers.toString()}');
    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        isLoading = false;
      });

      print('profile response: ${jsonDecode(response.body)}');

      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {

      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        isLoading = false;
      });

      Utils.displayToast('Something went wrong !');

      throw Exception('Failed to load profile data ${response.body}');
    }
  }


}

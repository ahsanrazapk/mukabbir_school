import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/bg_image_container.dart';
import 'package:mukabbir_schools/model/profile_img_update.dart';
import 'package:mukabbir_schools/model/profile_model.dart';
import 'package:mukabbir_schools/screen/change_password/change_password_screen.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:http/http.dart' as http;
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/utils.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //image
  final _picker = ImagePicker();
  PickedFile? _imageFile;

  //late ProfileModel profileModel;

  bool isLoading = true;
  late String tokenValue;

  @override
  void initState() {

    _getToken().then((value) {

      /*_fetchProfileData(value).then((profile) => {

        setState(() {
          tokenValue = value;
          profileModel = profile;
        }),

      });*/

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
        //child: isLoading ? Utils.loadingWidget() : Stack(
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
              bottom: -20,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/bottom_circle.png', width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.14, fit: BoxFit.cover,),
            ),



            ProgressHUD(child: Builder(
                builder: (cxt) => Padding(
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

                            _circleImage(Utils.profileModel.profileDetail.profileImg),

                            SizedBox(
                              height: 8.0,
                            ),

                            Center(child: Text(Utils.profileModel.profileDetail.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ColorConstants.blueColor))),

                            SizedBox(
                              height: 16.0,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [

                                  _cellNoAndClassRow(Utils.profileModel.profileDetail.contact, Utils.profileModel.profileDetail.grade),

                                  SizedBox(
                                    height: 16.0,
                                  ),

                                  //father name
                                  Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: [

                                      Container(
                                        height: 46.0,
                                        color: Colors.transparent,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 40.0),
                                                    child: Text("Father Name: ",
                                                        style: TextStyle(
                                                            color: ColorConstants.whiteColor)),
                                                  ),
                                                ),
                                                SizedBox(width: 24.0),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(Utils.profileModel.profileDetail.fatherName,
                                                      style: TextStyle(
                                                          color: ColorConstants.whiteColor)),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Image.asset('assets/images/circle_father_name.png', width: 56, height: 56,),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 8.0,
                                  ),

                                  //section name
                                  Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: [

                                      Container(
                                        height: 46.0,
                                        color: Colors.transparent,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 40.0),
                                                    child: Text("Section Name: ",
                                                        style: TextStyle(
                                                            color: ColorConstants.whiteColor)),
                                                  ),
                                                ),
                                                SizedBox(width: 24.0),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(Utils.profileModel.profileDetail.section,
                                                      style: TextStyle(
                                                          color: ColorConstants.whiteColor)),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Image.asset('assets/images/cirlce_name.png', width: 56, height: 56,),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 8.0,
                                  ),

                                  //date of birth
                                  Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: [

                                      Container(
                                        height: 46.0,
                                        color: Colors.transparent,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 40.0),
                                                    child: Text("Date of Birth: ",
                                                        style: TextStyle(
                                                            color: ColorConstants.whiteColor)),
                                                  ),
                                                ),
                                                SizedBox(width: 24.0),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(Utils.profileModel.profileDetail.dateOfBirth,
                                                      style: TextStyle(
                                                          color: ColorConstants.whiteColor)),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Image.asset('assets/images/circle_dob.png', width: 56, height: 56,),

                                    ],
                                  ),


                                  SizedBox(
                                    height: 8.0,
                                  ),

                                  //date of joining
                                  Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: [

                                      //date of joining
                                      Container(
                                        height: 46.0,
                                        color: Colors.transparent,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 40.0),
                                                    child: Text("Date of Joining: ",
                                                        style: TextStyle(
                                                            color: ColorConstants.whiteColor)),
                                                  ),
                                                ),
                                                SizedBox(width: 24.0),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(Utils.profileModel.profileDetail.joiningDate,
                                                      style: TextStyle(
                                                          color: ColorConstants.whiteColor)),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Image.asset('assets/images/circle_doj.png', width: 56, height: 56,),


                                    ],
                                  ),


                                  SizedBox(
                                    height: 16.0,
                                  ),

                                  //change password button
                                  SizedBox(
                                    width: double.maxFinite,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () {

                                        print('Change password Button Pressed');

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ChangePasswordScreen(),
                                          ),
                                        );

                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),

                                      ),
                                      child: Text(AppStrings.changePasswordButtonText
                                          .toUpperCase()),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 8.0,
                                  ),

                                  //upload button
                                  SizedBox(
                                    width: double.maxFinite,
                                    height: 48,
                                    child:
                                    ElevatedButton(
                                      onPressed: () {
                                        print('Upload picture Button Pressed');

                                        if(_imageFile != null) {
                                          _updateUserProfileWithImage(cxt, tokenValue).then((value) => {
                                            Utils.displayToast(value.message),
                                          });
                                        }
                                        else {
                                          //do nothing
                                          print('no image to upload !');
                                          Utils.displayToast('Please select profile image to upload');
                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white, //background color of button
                                        side: BorderSide(
                                          width: 2.0,
                                          color: ColorConstants.blueColor,
                                        ),
                                        shape: RoundedRectangleBorder( //to set border radius to button
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),

                                      ),
                                      child: Text(AppStrings.uploadPictureButtonText.toUpperCase(), style: TextStyle(color: ColorConstants.blueColor)),
                                    ),
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
              ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Row _cellNoAndClassRow(String cellNo, String grade) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  //Icon(Icons.person, color: ColorConstants.blackColor),
                  Image.asset('assets/images/cell_no_icon.png', width: 24, height: 24,),
                  SizedBox(width: 16.0),
                  Text(cellNo,
                      style: TextStyle(
                          fontSize: 14, color: ColorConstants.blackColor)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //Icon(Icons.person, color: ColorConstants.blackColor),
                  Image.asset('assets/images/class_icon.png', width: 24, height: 24,),
                  SizedBox(width: 16.0),
                  Text(grade,
                      style: TextStyle(
                          fontSize: 14, color: ColorConstants.blackColor)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleImage(String image) {
    print(image);
    return InkWell(
      onTap: () {
        _showPicker(context);
      },
      child: _imageFile != null ? CircleAvatar(
        radius: 70,
        backgroundImage: FileImage(File(_imageFile!.path)),
      ) :
      CircleAvatar(
        radius: 70,
        backgroundImage: CachedNetworkImageProvider(image),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {

    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print('image picker error: $e');
    }


  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print('image picker error: $e');
    }

    print('image path: ${_imageFile!.path}');

  }


  /*Future<ProfileModel> _fetchProfileData(String token) async {

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

      throw Exception('Failed to load profile data ${response.body}');
    }
  }*/


  Future<ProfileImgUpdate> _updateUserProfileWithImage(BuildContext cxt, String token) async {

    final progress = ProgressHUD.of(cxt);
    progress?.showWithText('Loading...');


    List<int> imageBytes = await _imageFile!.readAsBytes();
    String img64 = base64Encode(imageBytes);

    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseURL}/student-change-profile'));
    request.fields.addAll({
      'profile_image': '$img64'
    });


    print('base64 image: $img64');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var v = await response.stream.bytesToString();

    print( "status code -> ${response.statusCode}" );
    print( "response -> $v" );

    if (response.statusCode == 200) {

      setState(() {
        isLoading = false;
      });

      progress?.dismiss();

      return ProfileImgUpdate.fromJson(json.decode(v));
    }
    else {

      setState(() {
        isLoading = false;
      });

      progress?.dismiss();
      throw Exception('Failed update profile image ${json.decode(v)}');
    }

  }



}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/bg_image_container.dart';
import 'package:mukabbir_schools/components/gallery_image_item.dart';
import 'package:mukabbir_schools/model/gallery_model.dart';
import 'package:mukabbir_schools/utils/app_constants.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/shared_prefs.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:mukabbir_schools/utils/utils.dart';
import 'package:http/http.dart' as http;

class GalleryScreen extends StatefulWidget {

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {

  late GalleryModel galleryModelObj;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _getToken().then((value) {
      print('token value: $value');

      _fetchGalleryImages(value).then((gallery) => {

        setState(() {
          galleryModelObj = gallery;
        }),

      });

    });

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
        child: isLoading ? Utils.loadingWidget() : Stack(
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

                          Center(child: Text(AppStrings.galleryHeading, style: headingTextStyle)),

                          SizedBox(
                            height: 16,
                          ),

                          galleryModelObj.images.length != 0
                              ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: galleryModelObj.images.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return GalleryImageItem(item: galleryModelObj.images[index]);
                            },
                          )
                              : Utils.noDataWidget(
                              context, AppStrings.noImagesUploaded),

                          SizedBox(
                            height: 8,
                          ),

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

  Future<GalleryModel> _fetchGalleryImages(String token) async {

    print('sending token: $token');
    final response = await http.get(
        Uri.parse('${AppConstants.baseURL}/gallery'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );


    print('request: ${response.request?.headers.toString()}');
    print('gallery response: ${response.body}');


    if(response.body.contains('false')) {

      setState(() {
        isLoading = false;
      });

      return GalleryModel(status: 200, type: false, images: [], message: 'Data not found');
    }


    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        isLoading = false;
      });

      print('gallery response: ${jsonDecode(response.body)}');

      return GalleryModel.fromJson(jsonDecode(response.body));
    } else {

      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        isLoading = false;
      });

      throw Exception('Failed to load gallery images ${response.body}');
    }
  }


}


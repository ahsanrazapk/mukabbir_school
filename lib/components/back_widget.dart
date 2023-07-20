import 'package:flutter/material.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/styles.dart';

class BackWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0.0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 20.0,
            ),

            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: ColorConstants.blackColor),
                  Text('Back', style: normalTextStyle),
                ],
              ),
            ),

            /*SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
            ),*/

          ],
        ),
      ),
    );
  }
}

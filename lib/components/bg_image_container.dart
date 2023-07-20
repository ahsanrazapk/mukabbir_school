import 'package:flutter/material.dart';

class BgImageContainer extends StatelessWidget {

  const BgImageContainer({
    Key? key,
    required String image,
  }) : _image = image, super(key: key);

  final String _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

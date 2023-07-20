import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required String text,
    required Function callback,
  }) : _text = text, _callback = callback, super(key: key);

  final String _text;
  final Function _callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 48,
      child: ElevatedButton(
        child: Text(_text),
        onPressed: () {
          print('Button Pressed');
          _callback();
        },
      ),
    );
  }
}

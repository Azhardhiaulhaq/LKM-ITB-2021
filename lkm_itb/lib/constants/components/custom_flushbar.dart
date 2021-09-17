import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class CustomFlushBar extends StatelessWidget {
  final String title;
  final String message;
  final BuildContext customContext;

  const CustomFlushBar({Key? key, required this.title, required this.message, required this.customContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      title: this.title,
      titleColor: Colors.white,
      message: this.message,
      messageColor: Colors.white,
      duration: Duration(seconds: 2),
      backgroundColor: ConstColor.invalidEntry,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      leftBarIndicatorColor: Colors.blue[300],
    )..show(customContext);
  }
}

import 'package:flutter/material.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class LoadingProgress extends StatelessWidget {
  final bool isLoading;

  const LoadingProgress({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  color: ConstColor.darkGreen,
                )),
          )
        : Container();
  }
}

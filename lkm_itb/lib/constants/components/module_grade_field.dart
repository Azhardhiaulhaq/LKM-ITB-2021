import 'package:flutter/material.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class ModuleGradeField extends StatelessWidget {
  final TextEditingController textController;

  const ModuleGradeField({Key? key, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 60.0,
                height: 30,
                alignment: Alignment.center,
                child: TextField(
                  textAlign: TextAlign.center,
                    controller: textController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      fillColor: ConstColor.darkGreen,
                      filled: true,
                      focusedBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: ConstColor.darkGreen),
                          borderRadius: BorderRadius.circular(5)),
                      enabledBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: ConstColor.darkGreen),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    style: TextStyle(
                        fontSize: 16.0, color: ConstColor.whiteBackground))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

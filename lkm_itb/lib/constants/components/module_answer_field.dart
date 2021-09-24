import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class ModuleAnswerField extends StatelessWidget {
  final String title;
  final TextEditingController textController;

  const ModuleAnswerField(
      {Key? key, required this.title, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(alignment: Alignment.centerLeft, child : Text(
          title,
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
        )),
        SizedBox(height: 10),
        TextField(
            controller: textController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColor.lightGreen),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColor.lightGreen),
                  borderRadius: BorderRadius.circular(20)),
              fillColor: ConstColor.whiteBackground,
              filled: true,
              hintText: 'Isikan jawabanmu disini...',
            )),
      ],
    );
  }
}

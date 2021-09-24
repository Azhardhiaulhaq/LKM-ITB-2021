import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class LoadingProgress extends StatelessWidget {
  final bool isLoading;

  const LoadingProgress({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
                height: 150,
                width: 150,
                color: ConstColor.whiteBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: ConstColor.lightGrey,
                      color: ConstColor.darkGreen,
                      
                    ),
                    SizedBox(height: 30,),
                    Text('Mohon Menunggu...',
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: ConstColor.darkGreen), textAlign: TextAlign.center,)
                  ],
                )),
          )
        : Container();
  }
}

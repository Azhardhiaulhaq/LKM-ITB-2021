import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/'));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ConstColor.appBarBackground,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: ConstColor.whiteBackground,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 54,
                right: 54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo_lkm_itb.png",
                      height: 69.0*1.2,
                      width: 161.0*1.2,
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Latihan Kepemimpinan Mahasiswa\nVIII ITB 2021",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: ConstColor.blackText,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_itb.png",
                        height: 33.0,
                        width: 33.0,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Direktorat Kemahasiswaan\nInstitut Teknologi Bandung",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ConstColor.blackText,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}

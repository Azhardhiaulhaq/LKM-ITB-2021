import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class TentangKami extends StatefulWidget {
  TentangKami({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TentangKamiState createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(

      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [

          Positioned(
            top: 100,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo_lkm_itb.png",
                  height: 36.69 * 1.2,
                  width: 85.61 * 1.2,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "MOBILE",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: ConstColor.blackText,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Image.asset(
              "assets/images/login_background.png",
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 80,
            child: Image.asset(
              "assets/images/ganesha_man.png",
              height: 100 * 1.2,
              width: 70 * 1.2,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 80,
            child: Image.asset(
              "assets/images/ganesha_woman.png",
              height: 76 * 1.2,
              width: 54 * 1.2,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.485,
            left: 105,
            child: SvgPicture.asset('assets/svg/small_ellipse.svg'),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.453,
            right: 100,
            child: SvgPicture.asset('assets/svg/small_ellipse.svg'),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 450),
                  Container(
                      padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
                      color: ConstColor.lightGreen,
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: Column(
                        children: [
                          Text(
                            'Merupakan aplikasi interaktif sebagai pendukung program Latihan Kepemimpinan Mahasiswa di masa pandemi COVID-19. ',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: ConstColor.whiteBackground,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Salam generasi bangsa,\nTim Panitia',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: ConstColor.whiteBackground,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Text(
              'LKM VIII ITB © 2021',
              style: GoogleFonts.roboto(
                  fontSize: 10,
                  color: ConstColor.darkGreen,
                  fontWeight: FontWeight.w400),
            ),
          ),
                    Positioned(top: 40, left: 0, child: CustomBackButton( title: 'Tentang Kami',)),
        ],
      ),
    ));
  }
}

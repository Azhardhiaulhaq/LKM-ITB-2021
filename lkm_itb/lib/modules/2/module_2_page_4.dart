import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page4 extends StatefulWidget {
  Modul2Page4({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/4';

  @override
  _Modul2Page4State createState() => _Modul2Page4State(role);
}

class _Modul2Page4State extends State<Modul2Page4> {
  final String role;

  _Modul2Page4State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Yuk perhatikan Mentormu dengan saksama dan antusias yang luar biasa!',
        style: GoogleFonts.roboto(
          fontSize: 22,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Text(
            'Mentor menjelaskan sedikit rangkuman mengenai video tersebut.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Video animasi ini memuat beberapa informasi mengenai bagaimana sih seseorang itu mampu bersifat terbuka terhadap lingkungannya atau bisa jadi video ini menjadi pembelajaran bagi kita untuk bagaimana untuk menciptakan suasana atau kondisi yang bersifat terbuka dalam sebuah diskusi, percakapan dan hal-hal lainnya. Dalam video tersebut setidaknya ada dua hal penting untuk bagaimana kita bisa terbuka yaitu :\n\n 1. “You have to learn to reduce your filter”\n 2. “Ask the right questions.”',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Mentor secara langsung menjelaskan mengapa aspek keterbukaan ini penting untuk dibahas atau penting untuk dipelajari. ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Hal ini dikarenakan aspek keterbukaan akan mengugah rasa keberterimaan seseorang terhadap suatu kondisi/lingkungan dan secara tidak langsung akan membuat orang mulai peka terhadap bagaimana bersifat terbuka untuk saling membantu atau saling menolong baik secara personal maupun kelompok masyarakat.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                    child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    child: Text('Bagian 1',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/5')))
      ],
    ));
  }
}

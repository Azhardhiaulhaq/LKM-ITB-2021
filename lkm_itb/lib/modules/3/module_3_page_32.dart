import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page32 extends StatefulWidget {
  Modul3Page32({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/32';

  @override
  _Modul3Page32State createState() => _Modul3Page32State(role);
}

class _Modul3Page32State extends State<Modul3Page32> {
  final String role;

  _Modul3Page32State(this.role);

  // ignore: non_constant_identifier_names
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
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Semangat selalu dan sampai jumpa di mentoring berikutnya!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '“Success seems to be connected with action. Successful men keep moving. They make mistakes, but they dont quit”\n\nConrad Hilton',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Sampaikanlah narasi berikut kepada Menteemu!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Menjadi profesional harus dibangun sejak dini. Hal ini penting karena pembiasaan untuk bersikap profesional saat masih muda mencerminkan karakter saat kita bekerja dalam sebuah tim atau organisasi. Jangan pernah menyerah dan teruslah belajar. Semoga kesuksesan selalu mengiringi kita semua. Seperti yang disampaikan oleh Conrad Hilton, seorang businessman amerika yang terkenal dengan penemuannya untuk memberikan rating bintang 1 sampai 5 kepada setiap hotel di dunia.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '“Success seems to be connected with action. Successful men keep moving. They make mistakes, but they dont quit”\n\nConrad Hilton',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Minta Mentee on cam untuk foto bersama!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
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
                pushFunction: () => pushFunction('/module/3/page/33')))
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul4Page21 extends StatefulWidget {
  Modul4Page21({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/21';

  @override
  _Modul4Page21State createState() => _Modul4Page21State(role);
}

class _Modul4Page21State extends State<Modul4Page21> {
  final String role;

  _Modul4Page21State(this.role);

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
            'Semangat selalu dan jangan lupa tetap bahagia! Sampai jumpa di mentoring selanjutnya!',
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
            '“Apa yang ada di dalam dirimu pasti lebih kuat dari apa yang kamu hadapi saat ini”\n\nWeihenmayer',
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
            'Hai kamu! sampailah kita pada poin terakhir. Mengapa kepeloporan dicantumkan di akhir? Karena kualitas seorang pelopor yang dimaksud adalah yang terbaik, bukan hanya sekadar memulai tanpa adanya tujuan yang jelas. Pelopor disini juga termasuk teladan yang dimiliki seorang pribadi yang telah dengan konsisten dilakukan pada dirinya sendiri sebelum disebarluaskan ke lingkungan dan orang lain.',
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
            '“Apa yang ada di dalam dirimu pasti lebih kuat dari apa yang kamu hadapi saat ini”\n\nWeihenmayer',
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
                pushFunction: () => pushFunction('/module/4/page/22')))
      ],
    ));
  }
}

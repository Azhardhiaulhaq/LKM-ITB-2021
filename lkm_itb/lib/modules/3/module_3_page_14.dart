import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page14 extends StatefulWidget {
  Modul3Page14({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/14';

  @override
  _Modul3Page14State createState() => _Modul3Page14State(role);
}

class _Modul3Page14State extends State<Modul3Page14> {
  final String role;

  _Modul3Page14State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Buka hati dan telingamu, dengarkan dan resapi penjelasan Mentormu!',
        style: GoogleFonts.roboto(
          fontSize: 20,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentor() {
    return Container(
      height: SizeConfig.screenHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Berikan penjelasan lengkap mengenai video yang sudah ditonton bersama!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Semangat untuk selalu ingin berkembang harusnya dapat ditularkan kepada orang lain disekitar kita. Terutama dalam berorganisasi, keinginan untuk terus maju dan berkembang sangat diperlukan agar dapat memiliki motivasi untuk eksis dalam perubahan zaman VUCA. Menjadi perpetual learner adalah hakikat sejati seorang manusia yang selalu mencari cara bagaimana dapat bertahan di segala tantangan.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: SizeConfig.screenHeight*0.2,)
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
                    child: Text('Bagian 3',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ) ,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() :
                             _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/15')))
      ],
    ));
  }
}

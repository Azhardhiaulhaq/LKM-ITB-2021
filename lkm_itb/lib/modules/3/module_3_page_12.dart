import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page12 extends StatefulWidget {
  Modul3Page12({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/12';

  @override
  _Modul3Page12State createState() => _Modul3Page12State(role);
}

class _Modul3Page12State extends State<Modul3Page12> {
  final String role;

  _Modul3Page12State(this.role);

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
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Coba dengarkan penjelasan Mentormu!',
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
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Berilah penjelasan tentang menjadi pribadi yang selalu ingin berkembang dan belajar!',
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
            'Seseorang dapat digolongkan kedalam dua kategori. Pertama, orang dengan mentalitas diploma/sertifikat. Ini mengacu pada orang-orang yang sangat menjunjung tinggi gelar (gelar akademik), dan bukan pengetahuan, kompetensi, keterampilan, dan kepribadian karakter. Kedua adalah orang yang giat belajar, memperdalam penguasaan ilmunya, terus menerus meningkatkan keterampilan dan karakter kerja, dan mencoba untuk eksis dalam era baru yang kompetitif yaitu globalisasi dan sering disebut juga dengan pembelajar abadi atau perpetual learner.',
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
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/13')))
      ],
    ));
  }
}

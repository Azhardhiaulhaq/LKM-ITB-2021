import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page29 extends StatefulWidget {
  Modul3Page29({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/29';

  @override
  _Modul3Page29State createState() => _Modul3Page29State(role);
}

class _Modul3Page29State extends State<Modul3Page29> {
  final String role;

  _Modul3Page29State(this.role);

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
        'Dengarkan Mentormu dengan saksama ya!',
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
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Berikan penjelasan mengenai jawaban pertanyaan yang diberikan sebelumnya!',
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
            'Kedua gambar menjelaskan tentang orang yang sama sama sedang dikejar deadline. Namun, raut mereka berbeda. Hal ini dapat terjadi karena keduanya memiliki mindset dan semangat yang berbeda ketika menghadapi kondisi tersebut. Bekerja dalam tekanan menghasilkan 2 output yaitu pencapaian dan fatigue (kelelahan). Optimalisasi diri diperlukan supaya individu dapat mengarah kepada hasil pencapaian yang akhirnya mendapatkan penghargaan. Kalaupun tidak berhasil dan menyebabkan fatigue, harus ada mekanisme kontrol dan strategi untuk kembali keadaan optimal.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
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
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    child: Text('Bagian 7',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
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
                pushFunction: () => pushFunction('/module/3/page/30')))
      ],
    ));
  }
}

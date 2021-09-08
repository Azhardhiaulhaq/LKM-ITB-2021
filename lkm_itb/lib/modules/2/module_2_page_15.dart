import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page15 extends StatefulWidget {
  Modul2Page15({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/15';

  @override
  _Modul2Page15State createState() => _Modul2Page15State(role);
}

class _Modul2Page15State extends State<Modul2Page15> {
  final String role;

  _Modul2Page15State(this.role);

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Text(
            'Wah bunga mawar putih yang sangat cantik, ',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 24,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_rose.png',
            width: 150,
            height: 150,
          )),
          SizedBox(
            height: 40,
          ),
          Text(
            'Terimakasih sudah menyarankan Loki untuk memberikan bunga mawar putih ini. Mawar putih ini melambangkan kedamaian hidup, kesetiaan dan kemurnian. Jagalah selalu pertemanan dengan menjaga perilaku yang baik.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 24,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w600),
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: ConstColor.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            child: Image.asset(
                          'assets/images/icon_rose.png',
                          width: 30,
                          height: 30,
                        )),
                      ),
                      Text(
                        'Wah bunga mawar putih yang sangat cantik, terima kasih sudah menyarankan Loki untuk memberikan bunga mawar putih ini. Mawar putih ini melambangkan kedamaian hidup, kesetiaan dan kemurnian. Jagalah selalu pertemanan dengan menjaga perilaku yang baik.',
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Goresan luka akibat memetik tangkai bunga mawar terlihat jelas oleh Kimy. Meskipun goresan kecil akan perih ketika terkena keringat dan debu selama kerja bakti berlangsung. Kimy merasakan betapa perihnya luka di tangan Loki. Bantulah kimy untuk mencari 1 item yang dibutuhkan Loki sekarang.',
              style: GoogleFonts.roboto(
                  color: ConstColor.lightGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
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
                  role == 'mentor'
                      ? Positioned(
                          top: SizeConfig.screenHeight * 0.1,
                          child: Text('Bagian 3',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: ConstColor.lightGreen,
                                fontWeight: FontWeight.w700,
                              )),
                        )
                      : Container(),
                  Container(
                      color: role == 'mentor'
                          ? Colors.transparent
                          : ConstColor.lightGreen,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 60,
            child: Container(
                padding: EdgeInsets.all(10),
                color: role == 'mentor'
                    ? Colors.transparent
                    : ConstColor.whiteBackground,
                child: new CustomModuleButton(
                    pushFunction: () => pushFunction('/module/2/page/16'))))
      ],
    ));
  }
}

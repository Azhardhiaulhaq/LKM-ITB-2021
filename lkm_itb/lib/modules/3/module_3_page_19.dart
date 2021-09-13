import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page19 extends StatefulWidget {
  Modul3Page19({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/19';

  @override
  _Modul3Page19State createState() => _Modul3Page19State(role);
}

class _Modul3Page19State extends State<Modul3Page19> {
  final String role;

  _Modul3Page19State(this.role);

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
          Container(
              child: Image.asset(
            'assets/images/icon_naskah.png',
            width: 300,
            height: 300,
          )),
          SizedBox(
            height: 40,
          ),
          Text(
            'Selamat kamu telah menemukan item Naskah Drama. Dengan begitu, Loki dan Kimy bisa memahami alur drama dan seluruh hal yang berkaitan dengan perannya.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 26,
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
                  child: Text(
                    'Selamat kamu telah menemukan item Naskah Drama. Dengan begitu, Loki dan Kimy bisa memahami alur drama dan seluruh hal yang berkaitan dengan perannya.',
                    style: GoogleFonts.roboto(
                        color: ConstColor.whiteBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Selain drama, pada hari terakhir OSKM, diadakan lomba futsal yang dimodifikasi antar kelompok. Temukan item berharga untuk meningkatkan kekuatan kelompok dalam bertanding.',
            style: GoogleFonts.roboto(
                color: ConstColor.lightGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_naskah.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          )),
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
                          child: Text('Bagian 4',
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
                    pushFunction: () => pushFunction('/module/3/page/20'))))
      ],
    ));
  }
}

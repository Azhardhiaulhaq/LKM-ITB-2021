import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page23 extends StatefulWidget {
  Modul1Page23({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page23State createState() => _Modul1Page23State(role);
}

class _Modul1Page23State extends State<Modul1Page23> {
  final String role;

  _Modul1Page23State(this.role);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: ConstColor.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Congrats!',
                          style: GoogleFonts.roboto(
                            fontSize: 40,
                            color: ConstColor.whiteBackground,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/icon_jangka.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Hanya dengan dua pensil dan karet kamu bisa berhasil membuat jangka, kereeen lanjutin!!!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: ConstColor.whiteBackground),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Hanya dengan dua pensil dan karet kamu bisa berhasil membuat jangka, kereeen lanjutin!!!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 18, color: ConstColor.whiteBackground),
          ),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Text('Bagian 5',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 20,
        ),
        _contentMentor(),
        SizedBox(
          height: 50,
        ),
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: ConstColor.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Congrats!',
              style: GoogleFonts.roboto(
                fontSize: 40,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/icon_jangka.png',
            width: 150,
            height: 150,
          ),
          SizedBox(
            height: 20,
          ),
          _contentMentee(),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            role == 'mentor' ? _forMentor() : _forMentee(),
            Positioned(
                bottom: 60,
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: role == 'mentor'
                        ? Colors.transparent
                        : ConstColor.whiteBackground,
                    child: new CustomModuleButton(
                        pushFunction: () => pushFunction('/module/1/page/24'))))
          ]),
    ));
  }
}

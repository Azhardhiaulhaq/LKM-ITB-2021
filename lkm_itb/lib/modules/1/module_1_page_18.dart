import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page18 extends StatefulWidget {
  Modul1Page18({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page18State createState() => _Modul1Page18State(role);
}

class _Modul1Page18State extends State<Modul1Page18> {
  final String role;

  _Modul1Page18State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Berikan penjelasan mengenai pengertian berpikir konstruktif dan minta mentee membaca bergantian!',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pola berpikir konstruktif menekankan ketidakmungkinan memisahkan diri dari objek, yang mengetahui dari yang diketahui. Model ini mengakui pentingnya suara pribadi kita dan ketidakmungkinan menghilangkannya. Jadi selain mendengarkan dan bertanya tentang apa yang sedang dipikirkan kepada orang lain untuk mendapat inputan, kita juga memiliki hak untuk membangun pola pikir tersebut dari pemikiran pribadi kita. Hak tersebut bersifat setara dan sama. ',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
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
            'Yuk baca dengan hati-hati!',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pola berpikir konstruktif menekankan ketidakmungkinan memisahkan diri dari objek, yang mengetahui dari yang diketahui. Model ini mengakui pentingnya suara pribadi kita dan ketidakmungkinan menghilangkannya. Jadi selain mendengarkan dan bertanya tentang apa yang sedang dipikirkan kepada orang lain untuk mendapat inputan, kita juga memiliki hak untuk membangun pola pikir tersebut dari pemikiran pribadi kita. Hak tersebut bersifat setara dan sama.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _contentMentor(),
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _contentMentee(),
      ],
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
            Positioned(
              top: 40,
              child: Text('Bagian 4',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: ConstColor.lightGreen,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            role == 'mentor'
                ? Center(child: _forMentor())
                : Center(child: _forMentee()),
            Positioned(
                bottom: 70,
                child: CustomModuleButton(
                    pushFunction: () => pushFunction('/module/1/page/19')))
          ]),
    ));
  }
}

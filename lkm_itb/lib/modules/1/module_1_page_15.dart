import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page15 extends StatefulWidget {
  Modul1Page15({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;
  @override
  _Modul1Page15State createState() => _Modul1Page15State(role);
}

class _Modul1Page15State extends State<Modul1Page15> {
  final String role;

  _Modul1Page15State(this.role);

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
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Selamat kamu telah menemukan Laptop, beritahu Loki kalau ini akan membantu dia untuk analisis lebih dalam. Dengan bantuan apps dan browsing kemampuan analisisnya akan lebih akurat. Terima kasih banyak yaaa :)',
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            color: Colors.transparent,
            child: Text(
              'Loki membutuhkan item ini agar selalu tercatat dan tidak hilang karena hanya mengingatnya dalam pikiran. Berikan pinjaman item ini untuk Loki supaya bisa mencatat dengan baik. Kimy akan membantumu untuk mencarikan item ini.',
              style: GoogleFonts.roboto(
                  color: ConstColor.lightGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_laptop.png',
            width: 150,
            height: 150,
          ))
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'Selamat kamu telah menemukan Laptop!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 25,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            'assets/images/icon_laptop.png',
            width: 200,
            height: 200,
          ),
          Text(
            'Beritahu Loki kalau ini akan membantu dia untuk analisis lebih dalam. Dengan bantuan apps dan browsing kemampuan analisisnya akan lebih akurat.Terima kasih banyak :)',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 25,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.bold),
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
        Text('Bagian 3',
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
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      color: ConstColor.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          _contentMentee(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, alignment : Alignment.center,children: <Widget>[
        role == 'mentor' ? _forMentor() : _forMentee(),
        Positioned(
            
            bottom: 60,
            child: Container(
              alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: role == 'mentor'
                    ? Colors.transparent
                    : ConstColor.whiteBackground,
                child: new CustomModuleButton(
                    pushFunction: () => pushFunction('/module/1/page/16'))))
      ]),
    ));
  }
}

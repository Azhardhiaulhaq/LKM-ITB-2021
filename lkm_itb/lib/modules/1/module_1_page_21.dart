import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page21 extends StatefulWidget {
  Modul1Page21({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page21State createState() => _Modul1Page21State(role);
}

class _Modul1Page21State extends State<Modul1Page21> {
  final String role;

  _Modul1Page21State(this.role);

  _article() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Kotoran Ternak Jadi Parfum Ruangan',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/modul_1_21.png',
            fit: BoxFit.fill,
          ),
          SizedBox(height: 15),
          Text(
            'Nailul Izzah dan Rintya Miki meraih Juara III ajang International Environment Project Olympiade (INEPO) 2013 di Istanbul, Turki, pada 17-20 Mei 2013. Keduanya menemukan formula untuk mengubah kotoran sapi menjadi parfum pengharum ruangan. Bahan baku kotoran sapi ini dipilih karena syarat dari kontes tersebut adalah memilih bahan baku yang sangat mudah ditemui di sekitarnya. Populasi sapi berlebih di kabupaten Lamongan, tempat mereka tinggal dan sekolah adalah alasan utama dari penelitian ini.',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.justify,
          ),
          role == 'mentor' ? SizedBox(height: 15) : Container(),
          role == 'mentor'
              ? Text(
                  'Berpikir inovatif adalah kemampuan untuk memunculkan ide-ide baru dan pendekatan baru untuk masalah yang dihadapi. Secara mendasar, menjadi inovatif adalah tentang bagaimana menjadi kreatif dan fleksibel. Menjadi kreatif bukan berarti harus pure ide baru. Bisa saja adalah hasil gabungan dari dua buah ide lama. Misal, jika biasanya memakan dengan sendok dan garpu secara terpisah, kini sendok garpu bisa digabung menjadi satu agar lebih efektif.',
                  style: GoogleFonts.roboto(
                      color: ConstColor.whiteBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.justify,
                )
              : Container(),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  void pushFunction(String next_route){
    Navigator.pushNamed(context, next_route);
  }
  

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Berilah penjelasan mengenai berpikir inovatif!',
                style: GoogleFonts.roboto(
                    color: ConstColor.blackText,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: _article())),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Yuk simak penjelasan Mentormu dengan baik.',
                style: GoogleFonts.roboto(
                    color: ConstColor.blackText,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: _article())),
          SizedBox(
            height: 50,
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
        _contentMentor(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  _forMentee() {
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
        _contentMentee(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, alignment: Alignment.center,children: <Widget>[
        role == 'mentor' ? _forMentor() : _forMentee(),
        Positioned(
                bottom: 60,
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: role == 'mentor'
                        ? Colors.transparent
                        : ConstColor.whiteBackground,
                    child: CustomModuleButton(
                        pushFunction: () => pushFunction('/module/1/page/22'))))
      ]),
    ));
  }
}

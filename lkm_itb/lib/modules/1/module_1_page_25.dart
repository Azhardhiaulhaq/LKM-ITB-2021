import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page25 extends StatefulWidget {
  Modul1Page25({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page25State createState() => _Modul1Page25State(role);
}

class _Modul1Page25State extends State<Modul1Page25> {
  final String role;

  _Modul1Page25State(this.role);
  void pushFunction(String next_route){
    Navigator.pushNamed(context, next_route);
  }
 
  _contentMentor() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          children: [
            Text(
              'Berilah apresiasi dan kesimpulan pada mentoring kali ini! Berikan informasi mengenai pertemuan selanjutnya!',
              textAlign: TextAlign.justify,
              style:
                  GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Terima kasih sudah mengikuti mentoring dengan baik, semua pola pikir yang diajarkan pada hari ini adalah langkah awal untuk menjadi pribadi yang positif. Pribadi yang positif yang selalu mengedepankan pemikiran yang komprehensif terhadap suatu masalah. Pemikiran yang didasarkan dengan fakta, data, dan peduli terhadap argumen yang dibangun oleh orang lain. Mencari cara terbaik dan terunik untuk memecahkan masalah yang ada.',
              textAlign: TextAlign.justify,
              style:
                  GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                '“Kesanggupan untuk bersabar dan bertahan dalam pikiran yang positif merupakan dasar dari loncatan-loncatan manusia selanjutnya”\n\nMerry Riana',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: ConstColor.blackText,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Text(
              'Minta Mentee on cam untuk foto bersama!',
              textAlign: TextAlign.justify,
              style:
                  GoogleFonts.roboto(fontSize: 12, color: ConstColor.blackText),
            ),
          ],
        ),
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Yuk on cam, kita foto bersama!',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
              '“Kesanggupan untuk bersabar dan bertahan dalam pikiran yang positif merupakan dasar dari loncatan-loncatan manusia selanjutnya”\n\nMerry Riana',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: ConstColor.blackText,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _contentMentor(),

      ],
    ));
  }

  _forMentee() {
    return Center(child: SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _contentMentee(),
      ],
    )),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        role == 'mentor' ? Center(child:_forMentor()) : Center(child:_forMentee()),
        Positioned(bottom: 70, child: new CustomModuleButton(pushFunction: () => pushFunction('/module/1/page/26')))
      ]),
    ));
  }
}

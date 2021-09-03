import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page3 extends StatefulWidget {
  Modul1Page3({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page3State createState() => _Modul1Page3State(role);
}

class _Modul1Page3State extends State<Modul1Page3> {
  final String role;

  _Modul1Page3State(this.role);

  _Button(String next_route) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: ConstColor.blackText,
                        size: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.greyText,
                      shape: StadiumBorder()),
                )),
            SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, next_route);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.roboto(
                            fontSize: 15, color: ConstColor.whiteBackground),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: ConstColor.blackText,
                        size: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.lightGreen,
                      shape: StadiumBorder()),
                ))
          ],
        ));
  }

  _Text() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Minta Mentee untuk mengikuti mengikuti kalimat mentor sambil menutup mata',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Rileks dan bernapaslah perlahan. Melangkahlah, rabalah, pahamilah setiap detik yang dilewati. Segera setelah kamu menggantikan pikiran-pikiran negatif dengan yang positif, kamu akan mulai mendapatkan hasil yang positif.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '“Hidup itu bukan mengenai seberapa berat masalah yang datang menghampiriku, namun mengenai seberapa positif aku mampu merespons segala permasalahan tersebut. Aku bersyukur atas apa pun yang terjadi di hidupku, itu semua adalah pengalaman. Aku janji akan belajar dan membuang semua yang negatif dari dalam benakku. Karena hari ini hari baru bagiku dan pengalaman seru sudah menantiku.”',
            textAlign: TextAlign.justify,
            style: GoogleFonts.roboto(
                fontSize: 14,
                color: ConstColor.blackText,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Minta Mentee untuk menunggu selama dua menit sambil tetap memejamkan mata dan tetap untuk bernapas secara perlahan.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Minta Mentee untuk menceritakan apa yang sudah dirasakan selama dua menit refleksi.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
        ],
      ),
    );
  }

  _TextMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Yuk refleksi, \npejamkan mata kalian!',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 34, color: ConstColor.blackText),
          ),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                _Text(),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                ),
              ],
            )));
  }

  _forMentee() {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _TextMentee(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              top: 40,
              child: Text('Bagian 1',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: ConstColor.lightGreen,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            role == 'mentor' ? _forMentor() : Center(child: _forMentee()),
            Positioned(bottom: 70, child: _Button('/module/1/page/4'))
          ]),
    ));
  }
}

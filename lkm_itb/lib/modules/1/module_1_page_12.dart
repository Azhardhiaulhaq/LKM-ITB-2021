import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page12 extends StatefulWidget {
  Modul1Page12({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;
  @override
  _Modul1Page12State createState() => _Modul1Page12State(role);
}

class _Modul1Page12State extends State<Modul1Page12> {
  final String role;

  _Modul1Page12State(this.role);

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
                    'Yaa, kali ini kamu berhasil membantu Loki. Berkat Buku LKM, Loki memiliki banyak pengetahuan dan bisa memahami dengan mudah informasi dan mencernanya dengan baik.Selanjutnya silahkan temukan item lainnya untuk meringankan beban Loki, Ganbate!!!',
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
              'Tidak cukup dengan buku saja, Loki membutuhkan item lagi untuk menyelesaikan contoh soal untuk kesiapan ujian besok. Temukan item itu agar Loki dapat belajar dengan maksimal. Bekerjasamalah antara kamu dengan Kimy ya...',
              style: GoogleFonts.roboto(
                  color: ConstColor.lightGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_buku.png',
            width: 100,
            height: 100,
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
          Text(
            'Yaa, kali ini kamu berhasil membantu Loki. Berkat Buku LKM, Loki memiliki banyak pengetahuan dan bisa memahami dengan mudah informasi dan mencernanya dengan baik. Selanjutnya silahkan temukan item lainnya untuk meringankan beban Loki, Ganbate!!!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 23,
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
        Text('Bagian 2',
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
      height: MediaQuery.of(context).size.height,
      color: ConstColor.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Image.asset(
            'assets/images/icon_buku.png',
            width: 150,
            height: 150,
          ),
          SizedBox(
            height: 40,
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
                    child: CustomModuleButton(
                        pushFunction: () => pushFunction('/module/1/page/13'))))
          ]),
    ));
  }
}

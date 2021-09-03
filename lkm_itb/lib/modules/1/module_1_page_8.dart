import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page8 extends StatefulWidget {
  Modul1Page8({Key? key, required this.title, required this.role}) : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page8State createState() => _Modul1Page8State(role);
}

class _Modul1Page8State extends State<Modul1Page8> {
  final String role;

  _Modul1Page8State(this.role);

  _Button(String next_route) {
    return Container(
        color:
            role == 'mentee' ? ConstColor.whiteBackground : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Container(margin: EdgeInsets.all(20),child: Text(
              'Selamat item pertama telah ditemukan! kamu telah membantu menemukan Kacamata Loki yang telah hilang. Dengan kacamata ini Loki dapat melihat dengan jelas dari berbagai sudut yang dia lihat. \n\nSelanjutnya silahkan menyusuri kembali ruang itu bersama Kimy untuk membantu Loki!',
              style: GoogleFonts.roboto(
                  color: ConstColor.whiteBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),),
          )),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            color: Colors.transparent,
            child: Text(
              'Perasaan ragu akan berhasil, apakah Loki akan lulus ujian TPB? Bantu temukan item selanjutnya bersama Kimy untuk membantu Loki mencapai tujuan akhirnya. ',
              style: GoogleFonts.roboto(
                  color: ConstColor.lightGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_kacamata.png',
            width: 150,
            height: 150,
          ))
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
            'Item pertama telah ditemukan!\nkamu telah membantu menemukan Kacamata Loki yang telah hilang.\nDengan kacamata ini Loki dapat melihat dengan jelas dari berbagai sudut yang dia lihat.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 18, color: ConstColor.whiteBackground),
          ),
          SizedBox(height: 30),
          Text(
            'Selanjutnya silahkan menyusuri kembali ruang itu bersama Kimy untuk membantu Loki',
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
        Text('Bagian 1',
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
          height: MediaQuery.of(context).size.height*0.3,
        ),
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Container(
      alignment: Alignment.center,    
      height: MediaQuery.of(context).size.height,
      color: ConstColor.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 80,),
          Image.asset(
            'assets/images/icon_kacamata.png',
            width: 150,
            height: 150,
          ),
          Text('Selamat!!!',
              style: GoogleFonts.roboto(
                fontSize: 52,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(
            height: 20,
          ),
          _contentMentee(),
          SizedBox(
          height: MediaQuery.of(context).size.height*0.3,
        )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, alignment : Alignment.topCenter,children: <Widget>[
        role == 'mentor' ? _forMentor() : _forMentee(),
        Positioned(bottom: 55, child: _Button('/module/1/page/9'))
      ]),
    ));
  }
}

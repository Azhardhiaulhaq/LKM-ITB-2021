import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page19 extends StatefulWidget {
  Modul1Page19({Key? key, required this.title, required this.role}) : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page19State createState() => _Modul1Page19State(role);
}

class _Modul1Page19State extends State<Modul1Page19> {
  final String role;
  TextEditingController firstController = TextEditingController(text: "");

  _Modul1Page19State(this.role);

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
              'Daebaak, kamu telah memberikan pensil untul Loki agar bisa menuliskan catatan dan menggambar desain yang dia sedang kembangkan. Tinggal 1 item lagi, bantu Loki sampai akhir, terus semangaaat!!',
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
              'Tinggal 1 item lagi Loki bisa menyelesaikan desain yang dia gambar dan kembangkan, tetapi item itu hanya bisa dibuat dari penggabungan salah satu dari item sebelumnya. Buatlah 1 item bersama Kimy yang bisa membantu loki dalam pengerjaannya. Semangat!!!',
              style: GoogleFonts.roboto(
                  color: ConstColor.lightGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30,),
          Container(
              child: Image.asset(
            'assets/images/icon_pencil.png',
            width: 100,
            height: 100,
          ))
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 50,),
          Text(
            'Daebaak, kamu telah memberikan pensil untul Loki agar bisa menuliskan catatan dan menggambar desain yang dia sedang kembangkan. Tinggal 1 item lagi, bantu Loki sampai akhir, terus semangaaat!!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 25, color: ConstColor.whiteBackground,fontWeight: FontWeight.bold),
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
        Text('Bagian 4',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 20,
        ),
        _contentMentor(),
        SizedBox(height: MediaQuery.of(context).size.height*0.3,)
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
          SizedBox(height: 80,),
          Image.asset(
            'assets/images/icon_pencil.png',
            width: 100,
            height: 100,
          ),
          SizedBox(height: 50,),
          _contentMentee(),
          SizedBox(height: MediaQuery.of(context).size.height*0.3,)
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        role == 'mentor' ? _forMentor() : _forMentee(),
        Positioned(bottom: 55, child: _Button('/module/1/page/20'))
      ]),
    ));
  }
}

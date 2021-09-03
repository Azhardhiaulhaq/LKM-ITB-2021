import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page26 extends StatefulWidget {
  Modul1Page26({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page26State createState() => _Modul1Page26State(role);
}

class _Modul1Page26State extends State<Modul1Page26> {
  final String role;

  _Modul1Page26State(this.role);

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
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                    // Navigator.pushNamed(context, next_route);
                  },
                  child: Row(
                    children: [
                      Text(
                        'End',
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

  _contentMentee() {
    return Center(child:Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Terima kasih banyak!!!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 36,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30,),
          Text(
            'Sudah membantu Loki dalam persiapan ujiannya. Berkat kamu dan Kimy, Loki bisa lulus ujian TPB, yuhuu.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.normal),
          ),
           SizedBox(height: 30,),
        ],
      ),
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      color: ConstColor.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _contentMentee(),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        _forMentee(),
        Positioned(bottom: 70, child: _Button('/home'))
      ]),
    ));
  }
}

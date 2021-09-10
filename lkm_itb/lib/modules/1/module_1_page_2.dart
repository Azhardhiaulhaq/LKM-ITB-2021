import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page2 extends StatefulWidget {
  Modul1Page2({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page2State createState() => _Modul1Page2State(role);
}

class _Modul1Page2State extends State<Modul1Page2> {
  final String role;
  String text =
      'Bantulah Loki dalam mewujudkan impiannya menjadi kenyataan, butuh beberapa item untuk membantu Loki dalam mencapai tujuan akhirnya. Ketercapaian loki bergantung pada kalian. \n\nSilahkan menyusuri jalanan itu bersama Kimy.';

  _Modul1Page2State(this.role);

    // ignore: non_constant_identifier_names
    void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  // ignore: non_constant_identifier_names
  _Card() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
          color: ConstColor.lightGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(text,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: ConstColor.whiteBackground,
                        fontWeight: FontWeight.w700))),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset('assets/images/masuk_ITB.png'),
            )
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, alignment: Alignment.center,children: <Widget>[
        Positioned(
          top: 40,
          child: Text('Bagian 1',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 24,
                color: ConstColor.lightGreen,
                fontWeight: FontWeight.w700,
              )),
        ),
        Center(
            child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _Card(),
                  ],
                ))),
        Positioned(bottom: 70, child: new CustomModuleButton(pushFunction: () => pushFunction('/module/1/page/3')))
      ]),
    ));
  }
}

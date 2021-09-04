import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page13 extends StatefulWidget {
  Modul1Page13({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page13State createState() => _Modul1Page13State(role);
}

class _Modul1Page13State extends State<Modul1Page13> {
  final String role;

  _Modul1Page13State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Berilah penjelasan mengenai Berpikir Kritis berikut dan minta Mentee untuk membacanya secara bergantian!',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Seorang pemimpin harus dapat melihat suatu permasalahan secara utuh dan menelisik lebih jauh mengapa masalah tersebut dapat terjadi sesuai dengan kebenaran yang ada. Hal inilah yang disebut dengan berpikir kritis. Beyer mendefinisikannya sebagai kemampuan untuk membuat "penilaian yang beralasan" (1995). Pemikir kritis dengan demikian harus mampu menilai, mengevaluasi, dan mempertanyakan ide atau pemikiran berdasarkan bukti yang dapat diandalkan dengan membangun hubungan logis antara pernyataan atau data.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
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
            'Yuk baca baik baik!',
            textAlign: TextAlign.start,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Seorang pemimpin harus dapat melihat suatu permasalahan secara utuh dan menelisik lebih jauh mengapa masalah tersebut dapat terjadi sesuai dengan kebenaran yang ada. Hal inilah yang disebut dengan berpikir kritis. Beyer mendefinisikannya sebagai kemampuan untuk membuat "penilaian yang beralasan" (1995). Pemikir kritis dengan demikian harus mampu menilai, mengevaluasi, dan mempertanyakan ide atau pemikiran berdasarkan bukti yang dapat diandalkan dengan membangun hubungan logis antara pernyataan atau data.',
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
              child: Text('Bagian 3',
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
                    pushFunction: () => pushFunction('/module/1/page/14')))
          ]),
    ));
  }
}

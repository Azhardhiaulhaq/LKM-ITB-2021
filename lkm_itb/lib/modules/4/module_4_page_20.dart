import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';

import 'package:lkm_itb/constants/components/module_button.dart';

import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

// ignore: must_be_immutable
class Modul4Page20 extends StatefulWidget {
  Modul4Page20({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/20';
  String? menteeID;

  @override
  _Modul4Page20State createState() => _Modul4Page20State(role, menteeID);
}

class _Modul4Page20State extends State<Modul4Page20> {
  final String role;

  String? menteeID;
  bool isLoading = false;

  _Modul4Page20State(this.role, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void initState() {
    super.initState();
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Container(alignment: Alignment.centerLeft, child : Text(
            'Pertanyaan untuk menjadi seorang pelopor',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
            'Bagaimana jika… ?',
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),),
          SizedBox(
            height: 20,
          ),
          _image(),
          SizedBox(
            height: 5,
          ),
          Text(
            'Gambar 7',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Domino effect adalah salah manfaat yang akan muncul apabila dilontarkan pertanyaan “Bagaimana jika..?”',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Misalkan dalam suatu diskusi kamu dan kelompokmu menemui suatu masalah yang masih belum menemukan solusi dan ada satu pertanyaan yang bisa memantik suatu solusi yaitu:',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
            'Bagaimana jika… ?',
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pertanyaan tersebut dapat diberikan dan memantik jawaban-jawaban yang semakin membesar. Jawaban itu akan menjadi solusi-solusi dari masalah yang ada. Dari sini kita tahu bahwa kepeloporan itu tidak susah, hanya dengan bertanya untuk memantik jawaban-jawaban lain ternyata bisa dianggap menjadi pelopor lho!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          _image(),
          SizedBox(
            height: 5,
          ),
          Text(
            'Gambar 7',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Domino effect adalah salah manfaat yang akan muncul apabila dilontarkan pertanyaan “Bagaimana jika..?”. Domino dapat menjatuhkan domino lain dengan ukuran 1.5x lebih besar daripada ukurannya. Sehingga dengan ini, susunan domino sebanyak 57 batang sudah dapat menjangkau bulan lho!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
  }

  _image() {
    return Image.asset(
      'assets/images/modul_4_20.jpg',
      width: SizeConfig.screenWidth,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                    child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    child: Text('Bagian 6',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: role == 'mentor' ? _forMentor() : _forMentee()),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/4/page/21'))),
        new LoadingProgress(isLoading: isLoading)
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

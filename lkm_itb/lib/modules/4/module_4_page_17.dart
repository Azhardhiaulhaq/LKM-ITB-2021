import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';

import 'package:lkm_itb/constants/components/module_button.dart';

import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

// ignore: must_be_immutable
class Modul4Page17 extends StatefulWidget {
  Modul4Page17({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/17';
  String? menteeID;

  @override
  _Modul4Page17State createState() => _Modul4Page17State(role, menteeID);
}

class _Modul4Page17State extends State<Modul4Page17> {
  final String role;

  String? menteeID;
  bool isLoading = false;

  _Modul4Page17State(this.role, this.menteeID);

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
          Text(
            'Warna kuning dan Integritas emang nyambung?',
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
          _image(),
          SizedBox(
            height: 30,
          ),
          Text(
            'Dengarkan Mentormu dan diskusi yuk!',
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
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
            'Warna kuning dan Integritas emang nyambung?',
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
          _image(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Oke teman-teman, kali ini kita akan bahas integritas, jadi dari gambar diatas, ada yang bisa menceritakan tentang integritas? Gambar diatas adalah gambar Ketua DPR yang korupsi (Setya Novanto), Pak Soeharto (Presiden Kedua RI), dan Neymar (Pemain sepakbola yang sering ‘Diving’ atau menjatuhkan dirinya biar dikira dia dilanggar dan bisa dapet tendangan bebas).',
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
          Text(
            'Di akhir berikan pemahaman bahwa ini hanya contoh, bukan berarti warna kuning adalah warna yang tidak berintegritas yaa!',
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
      'assets/images/modul_4_17.png',
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
                pushFunction: () => pushFunction('/module/4/page/18'))),
        new LoadingProgress(isLoading: isLoading)
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

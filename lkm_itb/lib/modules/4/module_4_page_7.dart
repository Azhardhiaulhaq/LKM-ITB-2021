import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';

import 'package:lkm_itb/constants/components/module_button.dart';

import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

// ignore: must_be_immutable
class Modul4Page7 extends StatefulWidget {
  Modul4Page7({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/7';
  String? menteeID;

  @override
  _Modul4Page7State createState() => _Modul4Page7State(role, menteeID);
}

class _Modul4Page7State extends State<Modul4Page7> {
  final String role;

  String? menteeID;
  bool isLoading = false;

  _Modul4Page7State(this.role, this.menteeID);

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
            'Yuk dengarkan Mentormu dan perhatikan gambar di bawah ini ya!',
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          _image(),
          SizedBox(
            height: 30,
          ),
          Text(
            'Gambar 2',
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
          Text(
            'Bacakan narasi singkat di bawah ini untuk mentee.',
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
            'Pernah dengar atau tau gimana cara TNI bisa mempunyai ketangkasan di lapangan? Ya! Dengan berlatih halang rintang.Pernah dengar atau tau gimana cara TNI bisa mempunyai ketangkasan di lapangan? Ya! Dengan berlatih halang rintang.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 30,
          ),
          _image(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Gambar 2',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Dalam latihan halang rintang, terdapat beberapa rintangan yang harus dilewati oleh TNI agar dianggap lulus dan siap bertempur di lapangan. TNI tidak hanya melewati satu jenis rintangan yang mengharuskan untuk berlari atau menanjak, ada yang mengharuskan kita untuk saling membantu.',
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
      'assets/images/modul_4_7.jpg',
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
                    child: Text('Bagian 3',
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
                pushFunction: () => pushFunction('/module/4/page/8'))),
        new LoadingProgress(isLoading: isLoading)
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

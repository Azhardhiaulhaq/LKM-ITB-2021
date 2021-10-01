import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';


class Modul5Page2 extends StatefulWidget {
  Modul5Page2({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/5/page/2';

  @override
  _Modul5Page2State createState() => _Modul5Page2State(role);
}

class _Modul5Page2State extends State<Modul5Page2> {
  final String role;

  _Modul5Page2State(this.role);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
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
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                role == 'mentor'
                                    ? 'Sapalah Mentee dengan semangat untuk memulai mentoring kali ini!\n\nTanyakan pada Mentee apa yang diharapkan mereka setelah belajar modul ini. Silakan 2-3 Mentee untuk menyampaikan pendapatnya!'
                                    : 'Yuk dengarkan Mentormu!',
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: ConstColor.blackText,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/5/page/3')))
      ],
    ));
  }
}

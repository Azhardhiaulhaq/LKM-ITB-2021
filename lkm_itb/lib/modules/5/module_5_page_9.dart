import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';

import 'package:lkm_itb/constants/components/module_button.dart';

import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

// ignore: must_be_immutable
class Modul5Page9 extends StatefulWidget {
  Modul5Page9({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/5/page/9';
  String? menteeID;

  @override
  _Modul5Page9State createState() => _Modul5Page9State(role, menteeID);
}

class _Modul5Page9State extends State<Modul5Page9> {
  final String role;

  String? menteeID;
  bool isLoading = false;

  _Modul5Page9State(this.role, this.menteeID);

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
            height: SizeConfig.screenHeight * 0.1,
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
          Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: ConstColor.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Hidup Mahasiswa! Hidup Rakyat Indonesia',
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '“Perjuangan bangsa indonesia bukan hanya dari masa lalu. Hari ini, hari esok, dan selamanya. Perjuangan kita belum berakhir. Mari kita perjuangkan bersama untuk Indonesia yang Jaya.”',
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )),
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
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Text(
            'Sampaikanlah narasi berikut kepada menteemu!',
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
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: ConstColor.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Jadikan perbedaan sebagai sebuah keunikan dalam berbangsa dan bernegara agar terlihat indah dengan banyaknya warna dan janganlah menjadikan sebuah perbedaan sebagai kesombongan akan rasa paling benar dalam berpikir dan bertindak karena perbedaan yang mengakibatkan perpecahan yang membuat bangsa dan negara melemah. Kemerdekaan bukan tanda untuk berhenti berjuang, tapi tanda untuk berjuang dengan lebih keras lagi.',
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '“Perjuangan bangsa indonesia bukan hanya dari masa lalu. Hari ini, hari esok, dan selamanya. Perjuangan kita belum berakhir. Mari kita perjuangkan bersama untuk Indonesia yang Jaya.”',
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
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
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: role == 'mentor' ? _forMentor() : _forMentee()),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/5/page/10'))),
        new LoadingProgress(isLoading: isLoading)
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

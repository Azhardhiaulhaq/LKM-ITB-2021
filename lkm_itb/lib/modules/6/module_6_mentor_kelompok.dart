import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

// ignore: must_be_immutable
class Modul6MentorKelompok extends StatefulWidget {
  Modul6MentorKelompok({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  _Modul6MentorKelompokState createState() => _Modul6MentorKelompokState(role);
}

class _Modul6MentorKelompokState extends State<Modul6MentorKelompok> {
  final String role;

  _Modul6MentorKelompokState(this.role);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void initState() {
    super.initState();
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          Text(
            'Minta setiap menteemu untuk mengupload proposal dan laporan akhir untuk proyek kelompok yang dikerjakan',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: ConstColor.greyText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Data yang harus di-upload',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Proposal Proyek\nLaporan Akhir Proyek',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.bold,
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
                    child: Text('Kelompok',
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
                      child: _forMentor()),
                ])))),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

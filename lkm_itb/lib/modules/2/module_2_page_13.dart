import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page13 extends StatefulWidget {
  Modul2Page13({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/13';

  @override
  _Modul2Page13State createState() => _Modul2Page13State(role);
}

class _Modul2Page13State extends State<Modul2Page13> {
  final String role;

  _Modul2Page13State(this.role);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: SizeConfig.screenHeight,
      alignment: Alignment.center,
      child: Text(
        'Yuk simak penjelasan mentormu terkait maksud atau korelasi diagram tersebut terkait suatu hal!',
        style: GoogleFonts.roboto(
          fontSize: 22,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight*0.2,),

          Text(
            'Mentor memberikan penjelasan singkat mengenai maksud dari korelasi positif dua gambar tersebut. ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Mentor menjelaskan sekilas tentang diagram Maslow tersebut. ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Diagram ini memberikan exposure mengenai tingkatan kebutuhan manusia dari level paling dasar hingga paling tinggi. Hierarki ini menjelaskan bahwas idealnya untuk memenuhi kebutuhan manusia harus dimulai dari yang paling dasar terlebih dahulu dan hanya bisa ke pemenuhan level kebutuhan selanjutnya jika level kebutuhan sebelumnya terpenuhi.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Maksud dari penjelasan diagram Maslow adalah sebagai modal pendekatan untuk menjadi pribadi yang humanis dimana sebagaimana orientasi humanis itu adalah menciptakan tata interaksi sosial atau pergaulan yang lebih baik maka memahami kebutuhan manusia akan melancarkan segala tujuan atau orientasi yang melibatkan banyak di suatu organisasi atau sistem.',
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/14')))
      ],
    ));
  }
}

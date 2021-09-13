import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page3 extends StatefulWidget {
  Modul3Page3({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/3';

  @override
  _Modul3Page3State createState() => _Modul3Page3State(role);
}

class _Modul3Page3State extends State<Modul3Page3> {
  final String role;

  _Modul3Page3State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Yuk dengarkan Mentor!',
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
            'Berilah penjelasan mengenai kewajiban dan hak serta hubungannya dengan tanggung jawab!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Kewajiban adalah sesuatu yang harus dilaksanakan oleh seseorang sesuai dengan aturan yang berlaku. Hak adalah sesuatu yang didapatkan atau diterima seseorang jika telah melakukan serangkaian kegiatan. Untuk mendapatkan hak, segala sesuatu yang menjadi kewajiban harus dilakukan dengan penuh tanggung jawab.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Tanggung jawab juga bisa diartikan sebagai kesadaran manusia akan tingkah laku atau perbuatan yang disengaja maupun yang tidak disengaja. Jadi, secara sadar setiap perlakuan yang terjadi harus dapat kita pertanggungjawabkan kepada pihak yang bersangkutan, termasuk diri kita sendiri.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: SizeConfig.screenHeight*0.2,)
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
                    child: Text('Bagian 1',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ) ,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
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
                pushFunction: () => pushFunction('/module/3/page/4')))
      ],
    ));
  }
}

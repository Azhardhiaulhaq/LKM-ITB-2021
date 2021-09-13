import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page21 extends StatefulWidget {
  Modul3Page21({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/21';

  @override
  _Modul3Page21State createState() => _Modul3Page21State(role);
}

class _Modul3Page21State extends State<Modul3Page21> {
  final String role;

  _Modul3Page21State(this.role);

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
        'Yuk dengarkan Mentormu!',
        style: GoogleFonts.roboto(
          fontSize: 20,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentor() {
    return Container(
      height: SizeConfig.screenHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Berilah penjelasan mengenai gambar sebelumnya!',
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
            'Dua gambar tersebut menunjukkan bahwa persaingan yang sehat dapat memberikan hasil yang positif bagi sebuah organisasi. Terutama dalam kontestasi ide untuk menyelesaikan sebuah masalah atau studi kasus yang berhubungan dengan kemajuan organisasi. Menurut pendapat E. Durkheim dan K. Marx, persaingan adalah proses yang tidak memihak untuk terus menerus meningkatkan kualitas, pelayanan, dan sebagainya. Keinginan untuk lebih baik dari pesaing lainnya demi kemajuan organisasi adalah semangat yang ingin diajarkan dalam sifat ini.',
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
                    child: Text('Bagian 5',
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
                            role == 'mentor' ? _forMentor() :
                             _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/22')))
      ],
    ));
  }
}

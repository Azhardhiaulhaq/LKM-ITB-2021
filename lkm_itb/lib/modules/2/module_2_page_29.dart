import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page29 extends StatefulWidget {
  Modul2Page29({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/29';

  @override
  _Modul2Page29State createState() => _Modul2Page29State(role);
}

class _Modul2Page29State extends State<Modul2Page29> {
  final String role;

  _Modul2Page29State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Terima kasih banyak!!! ',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 40,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Sudah membantu Loki dan Kimy untuk berinteraksi bersama mahasiswa lain di kampus. Sungguh pengalaman yang asik dan menyenangkan!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 22,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w400),
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
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
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
                  child: Text(
                    'Yeyy, kamu berhasil menemukan obat luka untuk memberikan perlakuan dini terhadap luka Loki. Meskipun hanya luka goresan tetapi Kimy merasakan betapa perihnya ketika ditetesi dengan obat luka.',
                    style: GoogleFonts.roboto(
                        color: ConstColor.whiteBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Hari yang melelahkan, tak lupa dengan kebaikan yang Kimy berikan, Loki berencana memberikan hadiah kepada loki karena telah membantu kerja bakti waktu itu. Bantulah Loki menemukan hadiah yang unik untuk Kimy.',
            style: GoogleFonts.roboto(
                color: ConstColor.lightGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_puzzle.png',
            width: 100,
            height: 100,
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
                      color: ConstColor.lightGreen,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [_forMentee()])),
                ])))),
        Positioned(
            bottom: 60,
            child: Container(
                padding: EdgeInsets.all(10),
                color:  ConstColor.whiteBackground,
                child: CustomModuleButton(
                  pushFunction: () => pushFunction('/home'),
                  isEnd: true,
                )))
      ],
    ));
  }
}

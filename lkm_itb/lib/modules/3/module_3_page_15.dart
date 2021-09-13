import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page15 extends StatefulWidget {
  Modul3Page15({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/15';

  @override
  _Modul3Page15State createState() => _Modul3Page15State(role);
}

class _Modul3Page15State extends State<Modul3Page15> {
  final String role;

  _Modul3Page15State(this.role);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_book_fisiologi.png',
            width: 200,
            height: 200,
          )),
          SizedBox(
            height: 40,
          ),
          Text(
            'Item Buku Fisiologi Olahraga Lari ditemukan. Dengan buku itu, walaupun ia belum bisa lari lagi, wawasan yang ia tahu mengenai lari jadi semakin bertambah. Ia berencana menjelaskan hal yang ia dapat kepada teman-temannya agar kegiatan lari mereka jadi semakin bermanfaat.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 26,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w600),
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
                    'Item Buku Fisiologi Olahraga Lari ditemukan. Dengan buku itu, walaupun ia belum bisa lari lagi, wawasan yang ia tahu mengenai lari jadi semakin bertambah. Ia berencana menjelaskan hal yang ia dapat kepada teman-temannya agar kegiatan lari mereka jadi semakin bermanfaat.',
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
            'Pada hari terakhir OSKM, seluruh panitia memberikan persembahan terakhir berupa drama. Loki dan Kimy berperan sebagai pasangan Menteri. Sebagai persiapan, bantu Loki dan Kimy dalam menemukan item untuk membantunya berakting.',
            style: GoogleFonts.roboto(
                color: ConstColor.lightGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_book_fisiologi.png',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
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
                  role == 'mentor'
                      ? Positioned(
                          top: SizeConfig.screenHeight * 0.1,
                          child: Text('Bagian 3',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: ConstColor.lightGreen,
                                fontWeight: FontWeight.w700,
                              )),
                        )
                      : Container(),
                  Container(
                      color: role == 'mentor'
                          ? Colors.transparent
                          : ConstColor.lightGreen,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 60,
            child: Container(
                padding: EdgeInsets.all(10),
                color: role == 'mentor'
                    ? Colors.transparent
                    : ConstColor.whiteBackground,
                child: new CustomModuleButton(
                    pushFunction: () => pushFunction('/module/3/page/16'))))
      ],
    ));
  }
}

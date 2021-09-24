import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul4Page16 extends StatefulWidget {
  Modul4Page16({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/16';

  @override
  _Modul4Page16State createState() => _Modul4Page16State(role);
}

class _Modul4Page16State extends State<Modul4Page16> {
  final String role;

  _Modul4Page16State(this.role);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_picture.png',
            width: 200,
            height: 200,
          )),
          SizedBox(
            height: 40,
          ),
          Text(
            'Selamat item foto masa TPB telah ditemukan. Melihat ini membuat Loki mengingat masa TPB yang masih memiliki semangat dan rasa ingin tahu yang tinggi untuk mengeksplor diri. Mengingat bahwa dulu bisa melalui masa sulit, Loki merasa untuk masalah-masalah sekarang juga pasti akan terlewati',
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
                  child: Column(
                    children: [
                      Container(
                          child: Image.asset(
                        'assets/images/icon_picture.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Selamat item foto masa TPB telah ditemukan. Melihat ini membuat Loki mengingat masa TPB yang masih memiliki semangat dan rasa ingin tahu yang tinggi untuk mengeksplor diri. Mengingat bahwa dulu bisa melalui masa sulit, Loki merasa untuk masalah-masalah sekarang juga pasti akan terlewati',
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Rapat bulanan berlangsung secara rutin, permasalahan yang dibahas adalah terkait kasus pencurian barang dalam sekre himpunan. Tak ada satu anggota pun yang mengakui tindakan tersebut. Bantulah loki dalam menemukan pelaku pencurian tersebut. Bersama Kimy carilah barang yang dapat menyelesaikan masalah ini',
            style: GoogleFonts.roboto(
                color: ConstColor.lightGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
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
                  role == 'mentor'
                      ? Positioned(
                          top: SizeConfig.screenHeight * 0.1,
                          child: Text('Bagian 5',
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
                    pushFunction: () => pushFunction('/module/4/page/17'))))
      ],
    ));
  }
}

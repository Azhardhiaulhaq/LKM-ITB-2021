import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page23 extends StatefulWidget {
  Modul2Page23({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/23';

  @override
  _Modul2Page23State createState() => _Modul2Page23State(role);
}

class _Modul2Page23State extends State<Modul2Page23> {
  final String role;

  _Modul2Page23State(this.role);

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
          Text(
            'Kimy membuka kado dan tersenyum tipis dengan alis terangkat setelah melihat kado dari Loki. Topeng etnik ini sudah sejak lama dicari oleh Kimy, karena Kimy menyukai semua hal yang berkaitan dengan suku budaya bangsa.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 26,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              child: Image.asset(
            'assets/images/icon_topeng.png',
            width: 200,
            height: 200,
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
                    'Kimy membuka kado dan tersenyum tipis dengan alis terangkat setelah melihat kado dari Loki. Topeng etnik ini sudah sejak lama dicari oleh Kimy, karena Kimy menyukai semua hal yang berkaitan dengan suku budaya bangsa.',
                    style: GoogleFonts.roboto(
                        color: ConstColor.whiteBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.5,
                child: Text(
                  'Untuk mempererat pertemanan, Kimy berencana mengajak Loki untuk bermain suatu permainan. Bantulah Kimy dalam  mencari permainan apa yang cocok untuk dilakukan secara bersama.',
                  style: GoogleFonts.roboto(
                      color: ConstColor.lightGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/icon_topeng.png',
                    width: SizeConfig.screenWidth * 0.2,
                    fit: BoxFit.fill,
                  )),
            ],
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
                    pushFunction: () => pushFunction('/module/2/page/24'))))
      ],
    ));
  }
}

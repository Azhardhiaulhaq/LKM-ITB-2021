import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page1 extends StatefulWidget {
  Modul2Page1({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/1';

  @override
  _Modul2Page1State createState() => _Modul2Page1State(role);
}

class _Modul2Page1State extends State<Modul2Page1> {
  final String role;

  _Modul2Page1State(this.role);
  String text =
      'Salah satu acara orientasi kampus adalah gotong royong membersihkan lingkungan, dihari itu Loki belum sempat untuk sarapan, bantulah Loki agar bisa melaksanakan kegiatan dengan energi yang maksimal, belikan item ini untuk bisa memberikan energi, mintalah rekomendasi dari Kimy!';

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  _Card() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
          color: ConstColor.lightGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(text,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: ConstColor.whiteBackground,
                        fontWeight: FontWeight.w700))),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset('assets/images/masuk_ITB.png'),
            )
          ])),
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
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/modul%2F2%20SOCIAL%20SKILL.png?alt=media&token=4bceaf45-8799-43ef-a26c-55380bb3ae09',
                                fit: BoxFit.fill,
                                height: SizeConfig.screenHeight * 0.25,
                                width: SizeConfig.screenWidth),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Modul 2 - Jiwa Sosial',
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: ConstColor.lightGreen,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            _Card()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/2')))
      ],
    ));
  }
}

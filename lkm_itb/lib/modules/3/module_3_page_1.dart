import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page1 extends StatefulWidget {
  Modul3Page1({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/1';

  @override
  _Modul3Page1State createState() => _Modul3Page1State(role);
}

class _Modul3Page1State extends State<Modul3Page1> {
  final String role;

  _Modul3Page1State(this.role);
  String text =
      'Masa TPB usai. Kini, selain menjadi perwakilan angkatan untuk orientasi masuk himpunan, Loki dan Kimy juga tengah sibuk mengikuti kegiatan di Kepanitiaan OSKM sebagai mentor. Bantu Loki menemukan satu item agar ia bisa memperhatikan dan membagi waktu dalam berkegiatan.';

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
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset('assets/images/masuk_ITB.png'),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(text,
                    textAlign: TextAlign.end,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: ConstColor.whiteBackground,
                            fontWeight: FontWeight.w700))),
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
                                'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/modul%2F3%20BEING%20PROFESSIONAL.png?alt=media&token=dd2a4258-ff03-4873-9671-a5d584dcb5fa',
                                fit: BoxFit.fill,
                                height: SizeConfig.screenHeight * 0.25,
                                width: SizeConfig.screenWidth),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Modul 3 - Being Professional',
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
                pushFunction: () => pushFunction('/module/3/page/2')))
      ],
    ));
  }
}

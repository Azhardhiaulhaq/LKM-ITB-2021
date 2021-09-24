import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul4Page1 extends StatefulWidget {
  Modul4Page1({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/1';

  @override
  _Modul4Page1State createState() => _Modul4Page1State(role);
}

class _Modul4Page1State extends State<Modul4Page1> {
  final String role;

  _Modul4Page1State(this.role);
  String text =
      'Tidak terasa Loki dan Kimy sudah menjalani masa perkuliahan hampir 3 tahun. Berbagai kegiatan sudah dilewati oleh Loki dan Kimy. Sekarang sedang berlangsung masa transisi pemimpin organisasi kemahasiswaan. Namun ada beberapa ormawa yang tidak kunjung mendapatkan calon ketua karena tahun lalu banyak proker yang tidak terlaksana sehingga anggota tidak tertarik mendaftarkan diri. Begitu juga di ormawa yang diikuti oleh Loki dan Kimy. Bantulah Loki dan Kimy untuk menemukan satu item agar ormawa yang mereka ikuti tetap berjalan.';

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
                            fontSize: 12,
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
                                'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/modul%2F4%20FUTURE%20LEADERSHIP.png?alt=media&token=0975b013-831f-4106-8984-aa2918f779f1',
                                fit: BoxFit.fill,
                                height: SizeConfig.screenHeight * 0.25,
                                width: SizeConfig.screenWidth),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Modul 4 - Young Future Leader',
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: ConstColor.lightGreen,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            _Card(),
                            SizedBox(height: SizeConfig.screenHeight*0.2,)
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/4/page/2')))
      ],
    ));
  }
}

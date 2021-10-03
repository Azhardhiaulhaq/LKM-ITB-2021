import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul6Page1 extends StatefulWidget {
  Modul6Page1({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  String? menteeID;
  static const routeName = '/module/6/page/1';

  @override
  _Modul6Page1State createState() => _Modul6Page1State(role, menteeID);
}

class _Modul6Page1State extends State<Modul6Page1> {
  final String role;
  String? menteeID;
  _Modul6Page1State(this.role, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _laporanButton(String type, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: ConstColor.darkGreen),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: ConstColor.darkGreen,
                onTap: () async {
                  print('%%%%%%%%%%%%%%%%%%%%%%%');
                  print('/module/6/' + role + '/' + type);
                  Navigator.pushNamed(
                      context, '/module/6/' + role + '/' + type,
                      arguments: {'type': type, 'menteeID' : menteeID});
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                    child: Text(type,
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: ConstColor.whiteBackground,
                            fontWeight: FontWeight.w700))),
              )),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            text,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.lightGreen),
            textAlign: TextAlign.center,
          ),
        )
      ],
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
                            CachedNetworkImage(
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/modul%2F6%20PROJECT.png?alt=media&token=43dac4e1-9e68-4c40-bd9e-124ec6d067f3',
                              fit: BoxFit.fill,
                              height: SizeConfig.screenHeight * 0.25,
                              width: SizeConfig.screenWidth,
                              placeholder: (context, url) => Center(
                                child: LinearProgressIndicator(
                                  backgroundColor: ConstColor.boldGreyText,
                                  color: ConstColor.darkGreen,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Modul 6 - Project',
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: ConstColor.lightGreen,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            _laporanButton('individu',
                                'Proyek Individu merupakan laporan observasi mingguan yang dilakukan oleh setiap peserta dilembaganya masing masing'),
                            SizedBox(
                              height: 60,
                            ),
                            _laporanButton('kelompok',
                                'Proyek Kelompok dilaksanakan berdasarkan implementasi materi dan topik yang sudah didiskusikan setiap gabungan kelompoknya.'),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.2,
                            )
                          ])),
                ])))),
      ],
    ));
  }
}

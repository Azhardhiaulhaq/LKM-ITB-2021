import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul5Page1 extends StatefulWidget {
  Modul5Page1({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/5/page/1';

  @override
  _Modul5Page1State createState() => _Modul5Page1State(role);
}

class _Modul5Page1State extends State<Modul5Page1> {
  final String role;

  _Modul5Page1State(this.role);
  String text =
      'Berbagai rintangan yang Loki dan Kimy hadapi selama 4 tahun membuahkan hasil sesuai dengan target mereka. Lantas setelah lulus apa yang akan mereka lakukan? Kehidupan yang sebenarnya adalah disaat menentukan pilihan langkah dan arah mana yang akan dituju. Banyak sekali kesempatan Loki dan Kimy dapatkan jika mereka keluar negeri. Tapi mereka masih bimbang akan pilihannya. Apakah akan berbakti kepada NKRI atau mengambil pekerjaan dan pendidikan diluar dan menetap di sana? Semua ini tergantung kepada kalian, bantulah mereka untuk menyadarkan Loki dan Kimy akan arti nasionalisme.';

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
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(text,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: ConstColor.whiteBackground,
                              fontWeight: FontWeight.w700))),
                  Image.asset('assets/images/masuk_ITB.png'),
                ],
              ))),
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
                                  'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/modul%2F5%20NATIONALISM.png?alt=media&token=f23ec88c-dcfc-4e59-a240-2d5676767427',
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
                            Text('Modul 5 - Nasionalisme',
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: ConstColor.lightGreen,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            _Card(),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.2,
                            )
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/5/page/2')))
      ],
    ));
  }
}

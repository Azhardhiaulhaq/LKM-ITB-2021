import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';

class Modul4Page22 extends StatefulWidget {
  Modul4Page22({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/22';

  @override
  _Modul4Page22State createState() => _Modul4Page22State(role);
}

class _Modul4Page22State extends State<Modul4Page22> {
  final String role;

  _Modul4Page22State(this.role);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      await ModuleRepository.setAnswerStatus('3', sharedPrefs.userid)
          .then((value) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }
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
            'Terima kasih banyak!',
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
            'Terimakasih telah menemani perjalanan Loki menjadi ketua ormawa dari awal hingga akhir. Sampai jumpa minggu depan di kisah selanjutnya',
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
                child: new CustomModuleButton(
                  pushFunction: () => pushFunction('/home'),
                  isEnd: true,
                )))
      ],
    ));
  }
}

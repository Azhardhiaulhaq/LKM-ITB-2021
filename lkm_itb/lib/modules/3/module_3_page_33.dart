import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';

class Modul3Page33 extends StatefulWidget {
  Modul3Page33({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/33';

  @override
  _Modul3Page33State createState() => _Modul3Page33State(role);
}

class _Modul3Page33State extends State<Modul3Page33> {
  final String role;

  _Modul3Page33State(this.role);

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      print(sharedPrefs.userid);
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
            'Selamat sudah membuat Loki bisa menjadi pribadi versi terbaik ketika mengikuti kegiatan kemahasiswaan di kampus. Yuk, kita ikuti lagi kisahnya di minggu depan.',
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

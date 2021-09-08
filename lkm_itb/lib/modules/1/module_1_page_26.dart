import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';

class Modul1Page26 extends StatefulWidget {
  Modul1Page26({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page26State createState() => _Modul1Page26State(role);
}

class _Modul1Page26State extends State<Modul1Page26> {
  final String role;

  _Modul1Page26State(this.role);
  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      print(sharedPrefs.userid);
      await ModuleRepository.setAnswerStatus('1', sharedPrefs.userid)
          .then((value) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }
  }

  _contentMentee() {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Terima kasih banyak!!!',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 36,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Sudah membantu Loki dalam persiapan ujiannya. Berkat kamu dan Kimy, Loki bisa lulus ujian TPB, yuhuu.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: ConstColor.whiteBackground,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      color: ConstColor.lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _contentMentee(),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        _forMentee(),
        Positioned(
            bottom: 70,
            child:
                new CustomModuleButton(pushFunction: () => pushFunction('/home'), isEnd: true,))
      ]),
    ));
  }
}

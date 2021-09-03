import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';

class PenilaianLast extends StatefulWidget {
  PenilaianLast(
      {Key? key,
      required this.userID,
      required this.menteeID,
      required this.moduleID})
      : super(key: key);

  final String userID;
  final String menteeID;
  final String moduleID;
  static const routeName = '/penilaian/last';
  @override
  _PenilaianLastState createState() =>
      _PenilaianLastState(userID, menteeID, moduleID);
}

class _PenilaianLastState extends State<PenilaianLast> {
  final String userID;
  final String menteeID;
  final String moduleID;
  List<String> listQuestions = [];
  String mentorName = '';
  String menteeName = '';

  _PenilaianLastState(this.userID, this.menteeID, this.moduleID);

  _initProfile() async {
    await UserRepository.getUserDetail(userID).then((e) {
      setState(() {
        mentorName = e.get('name');
      });
    });
    await UserRepository.getUserDetail(menteeID).then((e) {
      setState(() {
        menteeName = e.get('name');
      });
    });
    await ModuleRepository.getModuleQuestions(moduleID).then((e) {
      setState(() {
        listQuestions = List.from(e.get('questions'));
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // Add the observer.
    _initProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Terima kasih atas penilaianmu \n untuk Mentee ' +
                    menteeName +
                    '!',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 21,
                    color: ConstColor.blackText,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/loki_penilaian.png',
              fit: BoxFit.fitHeight,
              height: 200,
            ),
            SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    await ModuleRepository.setGradeStatus(moduleID, menteeID)
                            .then((value) =>  Navigator.pushNamedAndRemoveUntil(context, '/progress', (_) => false));
                  },
                  child: Center(child: Text('Selesaikan Penilaian')),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.darkGreen,
                      shape: StadiumBorder()),
                ))
          ]),
    )));
  }
}

class PenilaianArguments {
  final String userID;
  final String moduleID;
  final String menteeID;

  PenilaianArguments(this.userID, this.moduleID, this.menteeID);
}

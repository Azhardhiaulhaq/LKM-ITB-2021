import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/1/module_1_page_4.dart';

class PenilaianFirst extends StatefulWidget {
  PenilaianFirst(
      {Key? key,
      required this.userID,
      required this.menteeID,
      required this.moduleID})
      : super(key: key);

  final String userID;
  final String menteeID;
  final String moduleID;
  static const routeName = '/penilaian/first';
  @override
  _PenilaianFirstState createState() =>
      _PenilaianFirstState(userID, menteeID, moduleID);
}

class _PenilaianFirstState extends State<PenilaianFirst> {
  final String userID;
  final String menteeID;
  final String moduleID;
  List<String> listQuestions = [];
  String mentorName = '';
  String menteeName = '';

  _PenilaianFirstState(this.userID, this.menteeID, this.moduleID);

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
    await ModuleRepository.getModuleQuestions(moduleID).then((e){
      setState((){
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
                'Hai, ' +
                    mentorName +
                    '!\nYuk nilai jawaban Mentee\n' +
                    menteeName,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 21,
                    color: ConstColor.blackText,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 50,),
            Image.asset('assets/images/loki_penilaian.png', fit: BoxFit.fitHeight, height: 200,),
            SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,Modul1Page4.routeName,arguments: {'menteeID' : menteeID});
                  },
                  child: Center(child: Text('Mulai Penilaian')),
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

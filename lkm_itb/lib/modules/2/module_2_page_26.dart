import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/components/module_answer_field.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/penilaian/penilaian_last.dart';


// ignore: must_be_immutable
class Modul2Page26 extends StatefulWidget {
  Modul2Page26({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/26';
  int module = 2;
  int page = 26;
  String? menteeID;

  @override
  _Modul2Page26State createState() =>
      _Modul2Page26State(role, module, page, menteeID);
}

class _Modul2Page26State extends State<Modul2Page26> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];

  _Modul2Page26State(this.role, this.module, this.page, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        gradeController.forEach((element) {
          listGrades.add(int.parse(element.text));
        });
        await ModuleRepository.initiateModuleGrades(
                module.toString(), menteeID!)
            .then((value) async {
          await ModuleRepository.addModuleGrades(module.toString(),
                  page.toString(), listGrades, menteeID!, sharedPrefs.group)
              .then((value) {
            Navigator.pushNamed(context, PenilaianLast.routeName, arguments: {
              'menteeID': menteeID,
              'userID': sharedPrefs.userid,
              'moduleID': module.toString()
            });
          });
        });
      } else {
        List<String> listAnswers = [];
        answerController.forEach((element) {
          listAnswers.add(element.text);
        });
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), listAnswers)
            .then((value) => Navigator.pushNamed(context, next_route));
      }
      setState(() {
        isLoading = false;
      });
    } else {
      Navigator.pushNamed(context, next_route);
    }
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Setelah menonton video animasi dan menjelaskan sedikit penjelasan mentormu, yuk berikan pendapat kamu tentang seberapa besar sih semangat kolaborasi ini untuk diri sendiri dan organisasi?',
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          new ModuleAnswerField(title: '', textController: answerController[0]),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[0])
              : Container(),
        ],
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Arahkan Mentee untuk mengisi bagian isian panjang terakhir pada sesi mentoring Jiwa Sosial kali ini. ',
            style: GoogleFonts.roboto(
              fontSize: 22,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade = await UserRepository.getUserGrade(
          module.toString(), menteeID!, page.toString());
      if (userGrade.exists) {
        var listString = List.from(userGrade.get('grades'));
        setState(() {
          for (var i = 0; i < listString.length; i++) {
            gradeController[i].text = listString[i].toString();
          }
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer = await UserRepository.getUserAnswers(
        module.toString(), id!, page.toString());
    if (userAnswer.exists) {
      var listString = List.from(userAnswer.get('answers'));
      setState(() {
        for (var i = 0; i < listString.length; i++) {
          answerController[i].text = listString[i] != null ? listString[i] : '';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gradeController.add(TextEditingController(text: '0'));
    answerController.add(TextEditingController(text: ""));
    // Add the observer.
    _initAnswer();
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
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    child: Text('Bagian 6',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: role == 'mentor' ? _forMentor() : _forMentee()),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/27'))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }

  @override
  void dispose() {
    answerController.forEach((element) {
      element.dispose();
    });
    gradeController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}

import 'package:another_flushbar/flushbar.dart';
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
import 'package:lkm_itb/modules/4/module_4_page_18.dart';

// ignore: must_be_immutable
class Modul4Page15 extends StatefulWidget {
  Modul4Page15({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/15';
  int module = 4;
  int page = 15;
  String? menteeID;

  @override
  _Modul4Page15State createState() =>
      _Modul4Page15State(role, module, page, menteeID);
}

class _Modul4Page15State extends State<Modul4Page15> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  // ignore: non_constant_identifier_names
  List<String> Question = [];
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];

  _Modul4Page15State(this.role, this.module, this.page, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route, BuildContext context) async {
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
            Navigator.pushNamed(context, Modul4Page18.routeName,
                arguments: {'menteeID': menteeID});
          }).onError((error, stackTrace) {
            isLoading = false;
            new Flushbar(
              title: 'Penambahan Nilai Gagal',
              titleColor: Colors.white,
              message: error.toString(),
              messageColor: Colors.white,
              duration: Duration(seconds: 3),
              backgroundColor: ConstColor.invalidEntry,
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              reverseAnimationCurve: Curves.decelerate,
              forwardAnimationCurve: Curves.elasticOut,
              leftBarIndicatorColor: Colors.blue[300],
            )..show(context);
          });
        });
      } else {
        List<String> listAnswers = [];
        answerController.forEach((element) {
          listAnswers.add(element.text);
        });
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), listAnswers)
            .then((value) => Navigator.pushNamed(context, next_route))
            .onError((error, stackTrace) {
          isLoading = false;
          new Flushbar(
            title: 'Penambahan Jawaban Gagal',
            titleColor: Colors.white,
            message: error.toString(),
            messageColor: Colors.white,
            duration: Duration(seconds: 3),
            backgroundColor: ConstColor.invalidEntry,
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            reverseAnimationCurve: Curves.decelerate,
            forwardAnimationCurve: Curves.elasticOut,
            leftBarIndicatorColor: Colors.blue[300],
          )..show(context);
        });
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
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Isikan dua baris pertama terkait resiliensi dalam individu dan dua baris terakhir terkait resiliensi kelompok.',
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            textAlign: TextAlign.justify,
          ),
          for (var i = 0; i < 4; i++) _answerField(i),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[0])
              : Container(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
        ],
      ),
    );
  }

  _answerField(int index) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        // Text(Question[index],
        //     style:
        //         GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
        //         textAlign: TextAlign.start,),
        new ModuleAnswerField(
            title: Question[index], textController: answerController[index]),
        SizedBox(
          height: 10,
        ),
      ],
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
            'Silahkan Mentor mengarahkan Menteenya untuk mengisi pertanyaan seputar faktor-faktor resiliensi.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 30,),
          Text(
            'Nah setelah selesai melihat video dan diskusi, yuk isikan beberapa faktor penyebab dan cara menjadi pribadi dan kelompok yang resilien dengan mengisikan pada kolom yg tertera!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
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
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    Question.add('Faktor penyebab tidak resilien - Pribadi');
    Question.add('Cara menjadi pribadi resilien');
    Question.add('Faktor penyebab tidak resilien - Kelompok');
    Question.add('Cara menjadi kelompok resilien');

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
                    child: Text('Bagian 5',
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
        new LoadingProgress(isLoading: isLoading),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/4/page/16', context))),
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

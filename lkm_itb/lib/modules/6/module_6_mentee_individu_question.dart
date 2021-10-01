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
import 'package:lkm_itb/modules/3/module_3_page_4.dart';

// ignore: must_be_immutable
class Modul6MenteeQuestion extends StatefulWidget {
  Modul6MenteeQuestion(
      {Key? key,
      required this.role,
      this.menteeID,
      required this.week,
      required this.dateString})
      : super(key: key);

  final String role;
  int module = 6;
  final int week;
  final String dateString;
  String? menteeID;

  @override
  _Modul6MenteeQuestionState createState() =>
      _Modul6MenteeQuestionState(role, module, week, menteeID, dateString);
}

class _Modul6MenteeQuestionState extends State<Modul6MenteeQuestion> {
  final String role;
  final int module;
  final int week;
  final String dateString;
  String? menteeID;
  bool isLoading = false;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];
  List<String> listQuestion = [];

  _Modul6MenteeQuestionState(
      this.role, this.module, this.week, this.menteeID, this.dateString);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (role == 'mentor') {
      List<int> listGrades = [];
      gradeController.forEach((element) {
        listGrades.add(int.parse(element.text));
      });
      await ModuleRepository.initiateModuleGrades(module.toString(), menteeID!)
          .then((value) async {
        await ModuleRepository.addModuleGrades(module.toString(),
                week.toString(), listGrades, menteeID!, sharedPrefs.group)
            .then((value) {
          Navigator.pushNamed(context, Modul3Page4.routeName,
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
              module.toString(), week.toString(), listAnswers)
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
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        pushFunction('/module/6/mentee/individu', context);
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: ConstColor.lightGreen,
              child: Text('Simpan',
                  style: GoogleFonts.roboto(
                      color: ConstColor.whiteBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 16)),
            ),
          )),
    );
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          Text(
            'Silahkan laporkan hasil observasi mingguan yang kamu lakukan',
            style: GoogleFonts.roboto(
                fontSize: 16,
                color: ConstColor.greyText,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Minggu ' + week.toString() + ', ' + dateString,
            style: GoogleFonts.roboto(
                fontSize: 16,
                color: ConstColor.darkGreen,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          for (var i = 0; i < 3; i++) _answerField(i),
          SizedBox(
            height: 10,
          ),
          _submitButton(context),
          role == 'mentor'
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 5,
        ),
        Text(listQuestion[index],
            style: GoogleFonts.roboto(
                fontSize: 16,
                color: ConstColor.lightGreen,
                fontWeight: FontWeight.normal)),
        new ModuleAnswerField(
            title: '', textController: answerController[index]),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade = await UserRepository.getUserGrade(
          module.toString(), menteeID!, week.toString());
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
        module.toString(), id!, week.toString());
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
    listQuestion.add('Nilai yang Diobservasi');
    listQuestion.add('Hasil Observasi');
    listQuestion.add('Saran Kepada Lembaga');

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
                    child: Text('Individu',
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
                      child: _forMentee()),
                ])))),
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

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
class Modul3Page2 extends StatefulWidget {
  Modul3Page2({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/2';
  int module = 3;
  int page = 2;
  String? menteeID;

  @override
  _Modul3Page2State createState() =>
      _Modul3Page2State(role, module, page, menteeID);
}

class _Modul3Page2State extends State<Modul3Page2> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];

  _Modul3Page2State(this.role, this.module, this.page, this.menteeID);

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
            'Halo, semoga kalian sehat selalu, kira kira, bagaimana perasaan kalian hari ini?',
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            textAlign: TextAlign.justify,
          ),
          new ModuleAnswerField(title: '', textController: answerController[0]),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[0])
              : Container(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          Text(
            'Kalo boleh tau, dalam satu minggu terakhir, aktivitas apa saja yang kamu sudah lakukan? (diluar rutinitas seperti mandi, makan, tidur, dan semacamnya)',
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            textAlign: TextAlign.justify,
          ),
          for (var i = 1; i < 8; i++) _answerField(i),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[1])
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
          height: 10,
        ),
        Text('Aktivitas ' + index.toString(),
            style:
                GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold)),
        new ModuleAnswerField(
            title: '', textController: answerController[index]),
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
            'Minta Mentee untuk menuliskan perasaannya pada hari ini pada kolom yang tersedia dan menuliskan aktivitas dalam satu pekan terakhir!',
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
    gradeController.add(TextEditingController(text: '0'));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
    answerController.add(TextEditingController(text: ""));
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
                    child: Text('Bagian 1',
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
                pushFunction: () => pushFunction('/module/3/page/3', context))),
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

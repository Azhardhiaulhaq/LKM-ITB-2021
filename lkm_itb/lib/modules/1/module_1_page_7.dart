import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_answer_field.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/1/module_1_page_10.dart';

// ignore: must_be_immutable
class Modul1Page7 extends StatefulWidget {
  Modul1Page7(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);

  final String title;
  final String role;
  static const routeName = '/module/1/page/7';
  String? menteeID;

  @override
  _Modul1Page7State createState() => _Modul1Page7State(role, menteeID);
}

class _Modul1Page7State extends State<Modul1Page7> {
  final String role;
  String? menteeID;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];

  _Modul1Page7State(this.role, this.menteeID);
  bool isLoading = false;

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        for (var controller in gradeController) {
          listGrades.add(int.parse(controller.text));
        }
        await ModuleRepository.addModuleGrades(
                "1", "7", listGrades, menteeID!, sharedPrefs.group)
            .then((value) => Navigator.pushNamed(
                context, Modul1Page10.routeName,
                arguments: {'menteeID': menteeID}));
      } else {
        List<String> listAnswers = [];
        for (var controller in answerController) {
          listAnswers.add(controller.text);
        }
        await ModuleRepository.addModuleAnswer("1", "7", listAnswers)
            .then((value) => Navigator.pushNamed(context, next_route));
      }
      setState(() {
        isLoading = false;
      });
    } else {
      Navigator.pushNamed(context, next_route);
    }
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Minta Mentee untuk menuliskan jawaban di kotak yang tersedia!',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 28, color: ConstColor.blackText),
          ),
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          new ModuleAnswerField(
              title:
                  'Jawablah pertanyaan berikut!\n\nNah, menurut kalian, di kondisi pandemi seperti ini, manakah yang lebih penting? Kesehatan atau Ekonomi?',
              textController: answerController[0]),
          menteeID != null
              ?new  ModuleGradeField(textController: gradeController[0])
              : Container()
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _contentMentor(),
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        _contentMentee(),
      ],
    ));
  }

  _initAnswer() async {
    if (menteeID != null) {
      print('--------');
      print(menteeID);
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '7');
      if (userGrade.exists) {
        var listString = List.from(userGrade.get('grades'));
        print(listString.toString());
        setState(() {
          for (var i = 0; i < listString.length; i++) {
            gradeController[i].text = listString[i].toString();
          }
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer =
        await UserRepository.getUserAnswers('1', id!, '7');
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
    answerController.add(TextEditingController(text: ''));
    gradeController.add(TextEditingController(text: '0'));
    // Add the observer.
    _initAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              top: 40,
              child: Text('Bagian 1',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: ConstColor.lightGreen,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            role == 'mentor' ? Center(child: _forMentor()) : _forMentee(),
            Positioned(
                bottom: 70,
                child: new CustomModuleButton(
                    pushFunction: () => pushFunction('/module/1/page/8'))),
            isLoading
                ? Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          color: ConstColor.darkGreen,
                        )),
                  )
                : Container()
          ]),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/components/module_answer_field.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/1/module_1_page_6.dart';

// ignore: must_be_immutable
class Modul1Page4 extends StatefulWidget {
  Modul1Page4(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);
  String? menteeID;
  final String title;
  final String role;
  static const routeName = '/module/1/page/4';

  @override
  _Modul1Page4State createState() => _Modul1Page4State(role, menteeID);
}

class _Modul1Page4State extends State<Modul1Page4> {
  String? menteeID;
  final String role;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];
  CollectionReference answers =
      FirebaseFirestore.instance.collection('answers');
  bool isLoading = false;

  _Modul1Page4State(this.role, this.menteeID);

  // ignore: non_constant_identifier_names
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

        await ModuleRepository.initiateModuleGrades('1', menteeID!)
            .then((value) async {
          await ModuleRepository.addModuleGrades(
                  "1", "4", listGrades, menteeID!, sharedPrefs.group)
              .then((value) => Navigator.pushNamed(
                  context, Modul1Page6.routeName,
                  arguments: {'menteeID': menteeID}));
        });
      } else {
        List<String> listAnswers = [];
        for (var controller in answerController) {
          listAnswers.add(controller.text);
        }
        await ModuleRepository.addModuleAnswer("1", "4", listAnswers)
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
        children: [
          Text(
            'Minta Mentee untuk berpendapat mengenai dua gambar berikut dan tuliskan dalam kotak yang tersedia.',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/modul_1_1.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.35,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Gambar 1',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: ConstColor.blackText),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/modul_1_2.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.35,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Gambar 2',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: ConstColor.blackText),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Minta Mentee untuk berpendapat mengenai dua gambar berikut dan tuliskan dalam kotak yang tersedia.',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/modul_1_1.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.35,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Gambar 1',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: ConstColor.blackText),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/modul_1_2.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.35,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Gambar 2',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: ConstColor.blackText),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 30),
          new ModuleAnswerField(
              title: 'Coba ceritakan apa yang terjadi pada gambar 1?',
              textController: answerController[0]),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[0])
              : Container(),
          SizedBox(height: 20),
          new ModuleAnswerField(
              title: 'Coba ceritakan apa yang terjadi pada gambar 2',
              textController: answerController[1]),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[1])
              : Container(),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 40),
        Text('Bagian 1',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(height: 40),
        _contentMentor(),
      ],
    ));
  }

  _initAnswer() async {
    if (menteeID != null) {

      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '4');
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
    DocumentSnapshot userAnswer =
        await UserRepository.getUserAnswers('1', id!, '4');
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
    // Add the observer.
    _initAnswer();
  }

  _forMentee() {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text('Bagian 1',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: ConstColor.lightGreen,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 40,
                ),
                _contentMentee(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ],
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: <Widget>[
                role == 'mentor' ? _forMentor() : _forMentee(),
                Positioned(
                    bottom: 70,
                    child: new CustomModuleButton(
                        pushFunction: () => pushFunction('/module/1/page/5'))),
                LoadingProgress(isLoading: isLoading),
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

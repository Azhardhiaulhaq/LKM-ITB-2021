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
import 'package:lkm_itb/modules/2/module_2_page_9.dart';

class Modul3Page8 extends StatefulWidget {
  Modul3Page8({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/8';
  int module = 3;
  int page = 8;
  String? menteeID;

  @override
  _Modul3Page8State createState() =>
      _Modul3Page8State(role, module, page, menteeID);
}

class _Modul3Page8State extends State<Modul3Page8> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];

  _Modul3Page8State(this.role, this.module, this.page, this.menteeID);

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
            Navigator.pushNamed(context, Modul2Page9.routeName,
                arguments: {'menteeID': menteeID});
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
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Coba dengarkan penjelasan Mentormu!',
            style:
                GoogleFonts.roboto(fontSize: 22, color: ConstColor.blackText),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height:50,
          ),
          new ModuleAnswerField(
              title:
                  'Menurut kamu mandiri yang berlebihan itu seperti apa sih?',
              textController: answerController[0]),
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

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Minta Mentee untuk mengingat kenangan masa kecilnya, kapan dia melakukan ‘sesuatu’ untuk pertama kalinya!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Kemandirian diartikan dengan hal atau keadaan seseorang dapat berdiri sendiri atau tidak bergantung kepada orang lain. Artinya kemandirian adalah kesiapan dan kemampuan individu untuk berdiri sendiri yang ditandai dengan mengambil inisiatif. Mandiri atau bebas menentukan dan melakukan apa yang diingini sendiri (self-autonomy) bukan berarti sama sekali tidak butuh kepada orang lain dan berhak atas apapun yang inginkan (total freedom). Dalam hidup tetap ada pembatasan. Pembatasan ini tersusun karena kontrol sosial dan kebutuhan sosial akan individu yang lain.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Minta Mentee untuk menyebutkan contoh mandiri yang berlebihan!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
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
                    child: Text('Bagian 2',
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
                      child: 
                      role == 'mentor' ? _forMentor() :
                       _forMentee()),
                ])))),
        new LoadingProgress(isLoading: isLoading),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/9'))),
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

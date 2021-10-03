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
import 'package:lkm_itb/modules/5/module_5_page_7.dart';

// ignore: must_be_immutable
class Modul5Page6 extends StatefulWidget {
  Modul5Page6({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/5/page/6';
  int module = 5;
  int page = 6;
  String? menteeID;

  @override
  _Modul5Page6State createState() =>
      _Modul5Page6State(role, module, page, menteeID);
}

class _Modul5Page6State extends State<Modul5Page6> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];
  List<String> bulletPoints = [];
  List<String> questionList = [];

  _Modul5Page6State(this.role, this.module, this.page, this.menteeID);

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
            Navigator.pushNamed(context, Modul5Page7.routeName,
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
            height: SizeConfig.screenHeight * 0.1,
          ),
          Text(
            'Dengarkan mentormu kemudian jawablah pertanyaan berikut!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          for (var i = 0; i < questionList.length; i++)
            new Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: new ModuleAnswerField(
                  title: questionList[i], textController: answerController[i]),
            ),
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
          _narration(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
        ],
      ),
    );
  }

  Widget _narration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.1,
        ),
        Text(
          'Berilah penjelasan tentang kaitan proses pengembangan karakter nasionalisme dan minta mentee menjawab pertanyaan yang disediakan!',
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: ConstColor.blackText,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Menurut Rajasa (2007), generasi muda mengembangkan karakter nasionalisme melalui tiga proses yaitu :',
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
        for (var val in bulletPoints)
          new Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: '• ',
                style: TextStyle(color: ConstColor.blackText, fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: val,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 14))),
                ],
              ),
            ),
          )
      ],
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
    bulletPoints.add(
        'Pembangun Karakter (character builder) yaitu generasi muda berperan membangun karakter positif bangasa melalui kemauan keras, untuk menjunjung nilai-nilai moral serta menginternalisasikannya pada kehidupan nyata. ');
    bulletPoints.add(
        'Pemberdaya Karakter (character enabler), generasi muda menjadi role model dari pengembangan karakter bangsa yang positif, dengan berinisiatif membangun kesadaran kolektif dengan kohesivitas tinggi, misalnya menyerukan penyelesaian konflik.');
    bulletPoints.add(
        'Perekayasa karakter (character engineer) yaitu generasi muda berperan dan berprestasi dalam ilmu pengetahuan dan kebudayaan, serta terlibat dalam proses pembelajaran dalam pengembangan karakter positif bangsa sesuai dengan perkembangan zaman.');
    questionList.add(
        'Berikan contoh aktivitas yang termasuk dalam character building untuk mengembangkan karakter nasionalisme di lembagamu!');
    questionList.add(
        'Berikan contoh aktivitas yang termasuk dalam character enabling untuk mengembangkan karakter nasionalisme di lembagamu!');
    questionList.add(
        'Berikan contoh aktivitas yang termasuk dalam character enabling untuk mengembangkan karakter nasionalisme di lembagamu!');
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
                pushFunction: () => pushFunction('/module/5/page/7', context))),
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

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/4/module_4_page_15.dart';

// ignore: must_be_immutable
class Modul4Page11 extends StatefulWidget {
  Modul4Page11({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/11';
  int module = 4;
  int page = 11;
  String? menteeID;

  @override
  _Modul4Page11State createState() =>
      _Modul4Page11State(role, module, page, menteeID);
}

class _Modul4Page11State extends State<Modul4Page11> {
  final String role;
  Map<int, List<String>> mapQuestions = Map();
  TextEditingController firstAnswerController =
      TextEditingController(text: "0");
  int module = 4;
  int page = 11;
  String? menteeID;
  List<bool> answers = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> questions = [
    'Mampu mengontrol emosi diri sendiri',
    'Tidak belajar dari pengalaman',
    'Memandang seluruh entitas dalam organisasi secara adil',
    'Terbuka terhadap keadaan yang terjadi',
    'Rela memperbaiki diri walaupun terasa berat',
    'Memandang dari satu sudut pandang',
    'Mengetahui manajemen energi pribadi dan tim',
  ];
  bool isLoading = false;
  _Modul4Page11State(this.role, this.module, this.page, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route, BuildContext context) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.initiateModuleGrades(
                module.toString(), menteeID!)
            .then((value) async {
          await ModuleRepository.addModuleGrades(module.toString(),
                  page.toString(), listGrades, menteeID!, sharedPrefs.group)
              .then((value) {
            Navigator.pushNamed(context, Modul4Page15.routeName,
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
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), answers)
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

  @override
  void dispose() {
    super.dispose();
  }

  _question(int index) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            questions[index],
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            textAlign: TextAlign.justify,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            setState(() {
              answers[index] = value ?? false;
            });
          },
          value: answers[index],
          activeColor: ConstColor.lightGreen,
          checkColor: ConstColor.whiteBackground,
        ),
        SizedBox(
          height: 5,
        ),
      ],
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
            'Ajak Menteemu untuk mendengarkan paparanmu!',
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: ConstColor.blackText,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Untuk lebih mengerti bagaimana cara mulai menerapkan adaptif pada diri sendiri, sesi ini ada beberapa checkboxes yang berisi tentang beberapa hal yang akan memudahkan kita dalam meningkatkan adaptif kita.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '1. Mampu mengontrol diri sendiri: meningkatkan kemampuan adaptif karena kita tidak mudah terpengaruh dengan lingkungan.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '2. Memandang seluruh entitas dalam organisasi secara adil: meningkatkan kemampuan adaptif karena dengan siapapun kita berinteraksi akan sama saja baiknya.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '3. Terbuka terhadap keadaan yang terjadi: memberikan kesempatan kita untuk dapat memandang info dengan cepat dan memudahkan adaptasi.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '4. Mengetahui manajemen energi: tidak mudah memboroskan energi, karena adaptasi juga membutuhkan energi.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
        ],
      ),
    );
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Yuk dengarkan Mentormu terlebih dahulu!',
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: ConstColor.blackText,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Bagaimana kita dapat meningkatkan kemampuan agile dan adaptive dalam diri kita?',
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 25,
          ),
          for (var i = 0; i < questions.length; i++) _question(i),
          SizedBox(
            height: 10,
          ),
          menteeID != null
              ? new ModuleGradeField(textController: firstAnswerController)
              : Container(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
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
          firstAnswerController.text =
              listString[0] != null ? listString[0].toString() : '0';
        });
      }
    }

    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    await UserRepository.getUserAnswers(module.toString(), id!, page.toString())
        .then((e) {
      if (e.exists) {
        List<bool?> listString = List.from(e.get('answers'));
        setState(() {
          for (var i = 0; i < listString.length; i++) {
            answers[i] = listString[i] ?? false;
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initAnswer();
    List<String> firstQuestions = [
      'Pernah',
      'Tidak lengkap dan cermat',
      'Tidak pernah',
    ];
    for (var i = 0; i < 5; i++) {
      mapQuestions[i] = firstQuestions;
    }
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
                    child: Text('Bagian 4',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () =>
                    pushFunction('/module/4/page/12', context))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

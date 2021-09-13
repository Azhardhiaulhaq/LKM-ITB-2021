import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/components/radio_tile.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/2/module_2_page_26.dart';

class Modul3Page16 extends StatefulWidget {
  Modul3Page16({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/16';
  int module = 3;
  int page = 16;
  String? menteeID;

  @override
  _Modul3Page16State createState() =>
      _Modul3Page16State(role, module, page, menteeID);
}

class _Modul3Page16State extends State<Modul3Page16> {
  final String role;
  Map<int, List<String>> mapQuestions = Map();
  TextEditingController firstAnswerController = TextEditingController(text: "0");
  int module = 3;
  int page = 16;
  String? menteeID;
  List<String> answers = [
    'Pernah',
    'Pernah',
    'Pernah',
    'Pernah',
    'Pernah'
  ];
  List<String> questions = [
    'Pernahkah kamu membaca pancasila secara lengkap dan cermat?',
    'Pernahkah kamu membaca UUD 1945 secara lengkap dan cermat?',
    'Pernahkah kamu membaca Statuta ITB secara lengkap dan cermat?',
    'Pernahkah kamu membaca Naskah Peraturan Akademik ITB secara lengkap dan cermat?',
    'Pernahkah kamu membaca AD/ART lembagamu secara lengkap dan cermat?'
  ];
  bool isLoading = false;
  _Modul3Page16State(this.role, this.module, this.page, this.menteeID);

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        print('menteeID');
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.initiateModuleGrades(
                module.toString(), menteeID!)
            .then((value) async {
          await ModuleRepository.addModuleGrades(module.toString(),
                  page.toString(), listGrades, menteeID!, sharedPrefs.group)
              .then((value) {
                Navigator.pushNamed(context, Modul2Page26.routeName,
                arguments: {'menteeID': menteeID});
              });
        });
      } else {
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), answers)
            .then((value) => Navigator.pushNamed(context, next_route));
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

  _question(String question, List<String> list, int index) {
    return Column(
      children: [
        Text(
          question,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: ConstColor.blackText,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.justify,
        ),
        _questionTile(list, index),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  _questionTile(List<String> list, int index) {
    return Column(
      children: <Widget>[
        for (String data in list)
          new LabeledRadio(
              label: data,
              padding: EdgeInsets.symmetric(horizontal: 5),
              groupValue: answers[index],
              value: data,
              onChanged: (String? value) {
                setState(() {
                  answers[index] = value ?? '';
                });
              },
              activeColor: ConstColor.lightGreen)
      ],
    );
  }

  _forMentor() {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Minta Mentee mengisi pertanyaan sesuai dengan yang tertera!',
        style: GoogleFonts.roboto(
          fontSize: 22,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
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
          for (var i = 0; i < questions.length; i++)
            _question(questions[i], mapQuestions.values.elementAt(i), i),
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
        List<String?> listString = List.from(e.get('answers'));
        setState(() {
          for (var i = 0; i < listString.length; i++) {
            answers[i] = listString[i] ?? '';
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
    for (var i = 0; i<5; i++){
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
                            role == 'mentor' ? _forMentor() :
                           _forMentee()])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/17'))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

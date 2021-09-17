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
import 'package:lkm_itb/modules/3/module_3_page_30.dart';

// ignore: must_be_immutable
class Modul3Page25 extends StatefulWidget {
  Modul3Page25({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/25';
  int module = 3;
  int page = 25;
  String? menteeID;

  @override
  _Modul3Page25State createState() =>
      _Modul3Page25State(role, module, page, menteeID);
}

class _Modul3Page25State extends State<Modul3Page25> {
  final String role;
  Map<int, List<String>> mapQuestions = Map();
  TextEditingController firstAnswerController =
      TextEditingController(text: "0");
  int module = 3;
  int page = 16;
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
    'Berani mengambil keputusan dan tindakan dengan tepat',
    'Menunggu dan mengobservasi orang lain untuk melakukan terlebih dahulu',
    'Mengganti ide dengan cepat untuk ketenaran',
    'Percaya diri dalam segala kondisi',
    'Menikmati tantangan dan hambatan yang dilewati',
    'Selalu berpetualang untuk mencari pengalaman',
    'Tidak apa apa terlambat asal berhasil mencapai tujuan',
    'Tidak apa apa terlambat asal selamat',
    'Bersegera dengan cepat supaya bisa melakukan koreksi ulang',
    'Bersegera dengan cepat supaya bisa bersantai'
  ];
  bool isLoading = false;
  _Modul3Page25State(this.role, this.module, this.page, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route, BuildContext context) async {
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
            Navigator.pushNamed(context, Modul3Page30.routeName,
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
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Minta Mentee memilih mana yang merupakan contoh penerapan sifat tangguh dan berdaya juang tinggi atau pantang menyerah!',
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
          Text(
            'Dari pilihan di bawah ini, menurut kamu mana yang merupakan contoh penerapan sifat tangguh dan berdaya juang tinggi (pantang menyerah)?',
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
                    child: Text('Bagian 6',
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
                pushFunction: () => pushFunction('/module/3/page/26', context))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

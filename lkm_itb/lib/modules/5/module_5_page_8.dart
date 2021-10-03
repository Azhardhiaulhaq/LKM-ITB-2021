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
import 'package:lkm_itb/modules/penilaian/penilaian_last.dart';

// ignore: must_be_immutable
class Modul5Page8 extends StatefulWidget {
  Modul5Page8({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/5/page/8';
  int module = 5;
  int page = 8;
  String? menteeID;

  @override
  _Modul5Page8State createState() =>
      _Modul5Page8State(role, module, page, menteeID);
}

class _Modul5Page8State extends State<Modul5Page8> {
  final String role;
  TextEditingController firstAnswerController =
      TextEditingController(text: "0");
  int module = 5;
  int page = 8;
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
    'Menjaga dan melindungi negara',
    'Selalu mengkritik pemerintah tapi tidak rasional',
    'Sikap rela berkorban/patriotisme',
    'Indonesia bersatu',
    'Menentang negara lain yang tidak sependapat ',
    'Melestarikan budaya Indonesia',
    'Cinta Tanah Air',
    'Doktrinasi pendapat mayoritas',
    'Bangga berbangsa Indonesia',
    'Menjunjung tinggi nilai kemanusiaan'
  ];
  bool isLoading = false;
  _Modul5Page8State(this.role, this.module, this.page, this.menteeID);

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
            Navigator.pushNamed(context, PenilaianLast.routeName, arguments: {
              'menteeID': menteeID,
              'userID': sharedPrefs.userid,
              'moduleID': module.toString()
            });
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Text(
            'Minta mentee untuk memilih mana yang merupakan sifat atau nilai yang harus diterapkan dalam membangun jiwa nasionalisme!',
            style: GoogleFonts.roboto(
                fontSize: 14,
                color: ConstColor.blackText,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          for (var question in questions) 
                    new Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: '• ',
                style: TextStyle(color: ConstColor.blackText, fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: question,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 14))),
                ],
              ),
            ),
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
            height: SizeConfig.screenHeight * 0.1,
          ),
          Text(
            'Pilihlah kalimat berikut yang menurutmu termasuk dalam nilai yang harus diterapkan dalam membangun jiwa nasionalisme!',
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: ConstColor.blackText,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
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
                    pushFunction('/module/5/page/9', context))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

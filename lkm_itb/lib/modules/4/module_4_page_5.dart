import 'package:another_flushbar/flushbar.dart';
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
import 'package:lkm_itb/modules/3/module_3_page_17.dart';
import 'package:lkm_itb/modules/4/module_4_page_8.dart';

// ignore: must_be_immutable
class Modul4Page5 extends StatefulWidget {
  Modul4Page5({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/5';
  int module = 3;
  int page = 16;
  String? menteeID;

  @override
  _Modul4Page5State createState() =>
      _Modul4Page5State(role, module, page, menteeID);
}

class _Modul4Page5State extends State<Modul4Page5> {
  final String role;
  Map<int, List<String>> mapQuestions = Map();
  TextEditingController firstAnswerController =
      TextEditingController(text: "0");
  int module = 3;
  int page = 16;
  String? menteeID;
  List<String> answers = [
    'Karena tempatnya estetik dan bisa digunakan untuk memanjakan mata dan juga menunjukkan status sosial'
  ];
  List<String> questions = [
    'Mengapa Starbuck memiliki pelanggan yang loyal walaupun harganya mahal ?',
  ];
  bool isLoading = false;
  _Modul4Page5State(this.role, this.module, this.page, this.menteeID);

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
            Navigator.pushNamed(context, Modul4Page8.routeName,
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
    return Column(children: [
      for (String data in list)
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: new Row(
          children: [
            LabeledRadio(
                label: '',
                padding: EdgeInsets.symmetric(horizontal: 5),
                groupValue: answers[index],
                value: data,
                onChanged: (String? value) {
                  setState(() {
                    answers[index] = value ?? '';
                  });
                },
                activeColor: ConstColor.lightGreen),
            SizedBox(
              width: 5,
            ),
            Container(
                width: SizeConfig.screenWidth * 0.65,
                child: Text(
                  data,
                  maxLines: 4,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                )),
          ],
        ),)

    ]);
    // Column(
    //   children: <Widget>[

    //   ],
    // );
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
          _image(),
          SizedBox(
            height: 5,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Gambar 1',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: ConstColor.blackText,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Ajak Mentee berdiskusi tentang mengapa Starbucks memiliki pelanggan yang loyal walaupun harganya mahal. Kaitkan dengan kehidupan berorganisasinya!',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: ConstColor.blackText,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Starbucks memiliki pelanggan yang loyal karena dia menjaga kualitasnya dan pelanggannya puas dengan kualitas itu. Jadi loyalitas yang terjadi dari diri pelanggan untuk senantiasa mengonsumsi produk starbucks bukan karena paksaan Starbucks namun karena kualitasnya ya!',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: ConstColor.blackText,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              )),
        ],
      ),
    );
  }

  _image() {
    return Container(
        child: Image.asset(
      'assets/images/modul_4_5.jpg',
      width: SizeConfig.screenWidth,
      fit: BoxFit.contain,
    ));
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
          _image(),
          SizedBox(
            height: 5,
          ),
          Text(
            'Gambar 1',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Apakah kamu mengenal merk dagang di atas? Ya itu adalah Starbucks Coffee.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 15,
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
      'Karena tempatnya estetik dan bisa digunakan untuk memanjakan mata dan juga menunjukkan status sosial',
      'Kualitas produknya yang dijaga dengan standar yang tinggi sehingga muncul ketertarikan dari konsumen secara alami',
      'Tidak ada pilihan lain selain Starbucks yang digunakan untuk tempat minum kopi',
      'Tempat menghabiskan uang yang kebanyakan'
    ];
    mapQuestions[0] = firstQuestions;
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
                pushFunction: () => pushFunction('/module/4/page/6', context))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

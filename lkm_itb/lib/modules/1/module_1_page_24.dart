import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/penilaian/penilaian_last.dart';

// ignore: must_be_immutable
class Modul1Page24 extends StatefulWidget {
  Modul1Page24(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);

  final String title;
  final String role;
  static const routeName = '/module/1/page/24';
  String? menteeID;

  @override
  _Modul1Page24State createState() => _Modul1Page24State(role, menteeID);
}

class _Modul1Page24State extends State<Modul1Page24> {
  final String role;
  String? menteeID;
  bool isLoading = false;

  List<String> listAnswer = ['', '', '', '', ''];
  List<String> listTitle = [
    'Berpikir Konstruktif',
    'Berpikir Dialogis',
    'Berpikir Holistik',
    'Berpikir Inovatif',
    'Berpikir Kritis'
  ];

  List<String> listHeader = [
    'Membangun dari banyak sisi',
    'Mendengarkan dan menerima',
    'Keseluruhan, melihat menyeluruh',
    'Melihat dan mencoba pembaruan',
    'Mencari lebih dalam berdasar fakta'
  ];
  TextEditingController firstAnswerController = TextEditingController(text: "");

  _Modul1Page24State(this.role, this.menteeID);
  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.addModuleGrades(
                "1", "24", listGrades, menteeID!, sharedPrefs.group)
            .then((value) => Navigator.pushNamed(
                    context, PenilaianLast.routeName, arguments: {
                  'menteeID': menteeID,
                  'userID': sharedPrefs.userid,
                  'moduleID': '1'
                }));
      } else {
        await ModuleRepository.addModuleAnswer("1", "24", listAnswer)
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
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Minta Mentee mencocokkan materi yang sudah disampaikan!',
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: ConstColor.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var i = 0; i < 5; i++)
                        _dragTargetMentor(listTitle[i], listHeader[i]),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _dragTargetMentor(String text, String title) {
    return Column(children: [
      Text(
        title,
        style: GoogleFonts.roboto(
            color: ConstColor.whiteBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 5),
      Card(
          color: ConstColor.whiteBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Container(
              width: 180,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    color: ConstColor.lightGreen, fontSize: 16),
              ))),
      SizedBox(height: 5),
    ]);
  }

  Widget _dragTarget(String text, int answerIndex, String title) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              color: ConstColor.whiteBackground,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        DragTarget<String>(
          onAccept: (value) {
            setState(() {
              listAnswer[answerIndex] = value;
            });
          },
          builder: (_, candidateData, rejectedData) {
            return Card(
                color: ConstColor.whiteBackground,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 2,
                child: Container(
                    width: 180,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      listAnswer[answerIndex],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: ConstColor.lightGreen, fontSize: 16),
                    )));
          },
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _dragSource() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable<String>(
              // Data is the value this Draggable stores.
              data: 'Berpikir Dialogis',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Dialogis',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
              child: Card(
                  color: ConstColor.greyText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Dialogis',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
            ),
            Draggable<String>(
              // Data is the value this Draggable stores.
              data: 'Berpikir Konstruktif',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Konstruktif',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
              child: Card(
                  color: ConstColor.greyText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Konstruktif',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable<String>(
              // Data is the value this Draggable stores.
              data: 'Berpikir Kritis',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Kritis',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
              child: Card(
                  color: ConstColor.greyText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Kritis',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable<String>(
              // Data is the value this Draggable stores.
              data: 'Berpikir Holistik',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Holistik',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
              child: Card(
                  color: ConstColor.greyText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Holistik',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
            ),
            Draggable<String>(
              // Data is the value this Draggable stores.
              data: 'Berpikir Inovatif',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Inovatif',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
              child: Card(
                  color: ConstColor.greyText,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Berpikir Inovatif',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _dragSource(),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: ConstColor.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var i = 0; i < 5; i++)
                        _dragTarget(listTitle[i], i, listHeader[i]),
                    ],
                  ),
                ),
              )),
          menteeID != null
              ? ModuleGradeField(textController: firstAnswerController)
              : Container()
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                _contentMentor(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ],
            )));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height,
      ),
      color: ConstColor.whiteBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text('Cocokkan jawaban pada isian berikut!',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: ConstColor.blackText,
                fontWeight: FontWeight.w400,
              )),
          _contentMentee(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ],
      ),
    ));
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '24');
      if (userGrade.exists) {
        var listString = List.from(userGrade.get('grades'));
        setState(() {
          firstAnswerController.text =
              listString[0] != null ? listString[0].toString() : '';
        });
      }
    }

    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    await UserRepository.getUserAnswers('1', id!, '24').then((e) {
      if (e.exists) {
        List<String?> listString = List.from(e.get('answers'));
        setState(() {
          for (var i = 0; i < listString.length; i++) {
            listAnswer[i] = listString[i] ?? '';
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Add the observer.
    _initAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        role == 'mentor' ? _forMentor() : _forMentee(),
        Positioned(
            bottom: 70,
            child: CustomModuleButton(
                pushFunction: () => pushFunction('/module/1/page/25'))),
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
}

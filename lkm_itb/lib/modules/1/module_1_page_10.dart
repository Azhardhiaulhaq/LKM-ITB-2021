import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/1/module_1_page_14.dart';

// ignore: must_be_immutable
class Modul1Page10 extends StatefulWidget {
  Modul1Page10(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);

  final String title;
  final String role;
  static const routeName = '/module/1/page/10';
  String? menteeID;

  @override
  _Modul1Page10State createState() => _Modul1Page10State(role, menteeID);
}

class _Modul1Page10State extends State<Modul1Page10> {
  final String role;
  TextEditingController firstController = TextEditingController(text: "");
  TextEditingController firstAnswerController = TextEditingController(text: "");
  String? menteeID;
  bool isLoading = false;
  _Modul1Page10State(this.role, this.menteeID);

  _Button(String next_route) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: ConstColor.blackText,
                        size: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.greyText,
                      shape: StadiumBorder()),
                )),
            SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (role == 'mentee') {
                      setState(() {
                        isLoading = true;
                      });
                      if (menteeID != null) {
                        List<int> listGrades = [];
                        listGrades.add(int.parse(firstAnswerController.text));
                        await ModuleRepository.addModuleGrades(
                                "1", "10", listGrades, menteeID!, sharedPrefs.group)
                            .then((value) => Navigator.pushNamed(
                                context, Modul1Page14.routeName,
                                arguments: {'menteeID': menteeID}));
                      } else {
                        List<String> listAnswers = [];
                        listAnswers.add(firstController.text);
                        await ModuleRepository.addModuleAnswer(
                                "1", "10", listAnswers)
                            .then((value) =>
                                Navigator.pushNamed(context, next_route));
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      Navigator.pushNamed(context, next_route);
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.roboto(
                            fontSize: 15, color: ConstColor.whiteBackground),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: ConstColor.blackText,
                        size: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.lightGreen,
                      shape: StadiumBorder()),
                ))
          ],
        ));
  }

  _penilaian(TextEditingController numController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 60.0,
                height: 30,
                alignment: Alignment.center,
                child: TextField(
                    controller: numController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      fillColor: ConstColor.darkGreen,
                      filled: true,
                      focusedBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: ConstColor.darkGreen),
                          borderRadius: BorderRadius.circular(5)),
                      enabledBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: ConstColor.darkGreen),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    style: TextStyle(
                        fontSize: 16.0, color: ConstColor.whiteBackground))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
          ),
          Text(
            'Dari video tersebut mintalah Mentee berpendapat!',
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
          Text(
            'Yuk keluarkan pendapatmu!\n\nKalau disuruh memilih dari ketiga karakter tersebut, siapa yang kamu pilih? Alasannya mengapa?',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(height: 20),
          TextField(
              controller: firstController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ConstColor.lightGreen),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ConstColor.lightGreen),
                    borderRadius: BorderRadius.circular(20)),
                fillColor: ConstColor.whiteBackground,
                filled: true,
                hintText: 'Isikan jawabanmu disini...',
              )),
          menteeID != null ? _penilaian(firstAnswerController) : Container()
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
        SizedBox(
          height: 40,
        ),
        Text('Bagian 2',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 20,
        ),
        _contentMentor(),
        SizedBox(
          height: 50,
        ),
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Text('Bagian 2',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 20,
        ),
        _contentMentee(),
        SizedBox(
          height: 50,
        ),
      ],
    ));
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '10');
      if (userGrade.exists) {
        var listString = List.from(userGrade.get('grades'));
        print(listString);
        setState(() {
          firstAnswerController.text =
              listString[0] != null ? listString[0].toString() : '';
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer =
        await UserRepository.getUserAnswers('1', id!, '10');
    if (userAnswer.exists) {
      var listString = List.from(userAnswer.get('answers'));
      print(listString);
      setState(() {
        firstController.text = listString[0] != null ? listString[0] : '';
      });
    }
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
        Positioned(bottom: 70, child: _Button('/module/1/page/11')),
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

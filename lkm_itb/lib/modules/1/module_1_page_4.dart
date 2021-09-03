import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/1/module_1_page_6.dart';

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
  TextEditingController firstController = TextEditingController(text: "");
  TextEditingController secondController = TextEditingController(text: "");
  TextEditingController firstAnswerController = TextEditingController(text: "");
  TextEditingController secondAnswerController =
      TextEditingController(text: "");
  CollectionReference answers =
      FirebaseFirestore.instance.collection('answers');
  bool isLoading = false;

  _Modul1Page4State(this.role, this.menteeID);
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
                        listGrades.add(int.parse(secondAnswerController.text));
                        await ModuleRepository.initiateModuleGrades(
                                '1', menteeID!)
                            .then((value) async {
                          await ModuleRepository.addModuleGrades("1", "4",
                                  listGrades, menteeID!, sharedPrefs.group)
                              .then((value) => Navigator.pushNamed(
                                  context, Modul1Page6.routeName,
                                  arguments: {'menteeID': menteeID}));
                        });
                      } else {
                        List<String> listAnswers = [];
                        listAnswers.add(firstController.text);
                        listAnswers.add(secondController.text);
                        await ModuleRepository.addModuleAnswer(
                                "1", "4", listAnswers)
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
          Text(
            'Coba ceritakan apa yang terjadi pada gambar 1?',
            textAlign: TextAlign.start,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(height: 10),
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
          menteeID != null ? _penilaian(firstAnswerController) : Container(),
          SizedBox(height: 20),
          Text(
            'Coba ceritakan apa yang terjadi pada gambar 2?',
            textAlign: TextAlign.start,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(height: 10),
          TextField(
              controller: secondController,
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
          menteeID != null ? _penilaian(secondAnswerController) : Container(),
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
          firstAnswerController.text =
              listString[0] != null ? listString[0].toString() : '0';
          secondAnswerController.text =
              listString[1] != null ? listString[1].toString() : '0';
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer =
        await UserRepository.getUserAnswers('1', id!, '4');
    if (userAnswer.exists) {
      var listString = List.from(userAnswer.get('answers'));
      setState(() {
        firstController.text = listString[0] != null ? listString[0] : '';
        secondController.text = listString[1] != null ? listString[1] : '';
      });
    }
  }

  @override
  void initState() {
    super.initState();

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
                Positioned(bottom: 70, child: _Button('/module/1/page/5')),
                isLoading
                    ? Center(
                        child: Container(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              color: ConstColor.darkGreen,
                            )),
                      )
                    : Container(),
              ]),
        ));
  }
}

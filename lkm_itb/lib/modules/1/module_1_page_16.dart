import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_answer_field.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/1/module_1_page_17.dart';

// ignore: must_be_immutable
class Modul1Page16 extends StatefulWidget {
  Modul1Page16(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);

  final String title;
  final String role;
  static const routeName = '/module/1/page/16';
  String? menteeID;

  @override
  _Modul1Page16State createState() => _Modul1Page16State(role, menteeID);
}

class _Modul1Page16State extends State<Modul1Page16> {
  final String role;
  TextEditingController firstController = TextEditingController(text: "");
  TextEditingController firstAnswerController = TextEditingController(text: "");
  String? menteeID;
  bool isLoading = false;
  _Modul1Page16State(this.role, this.menteeID);

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.addModuleGrades(
                "1", "16", listGrades, menteeID!, sharedPrefs.group)
            .then((value) => Navigator.pushNamed(
                context, Modul1Page17.routeName,
                arguments: {'menteeID': menteeID}));
      } else {
        List<String> listAnswers = [];
        listAnswers.add(firstController.text);
        await ModuleRepository.addModuleAnswer("1", "16", listAnswers)
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
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Minta Mentee untuk memberikan pendapat tentang berpikir konstruktif!',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(height: 50),
          Image.asset(
            'assets/images/modul_1_16.png',
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/images/modul_1_16.png',
            fit: BoxFit.fill,
          ),
          SizedBox(height: 30),
          Text(
            'Dari gambar tersebut, menurut kalian, apakah berpikir konstruktif itu? ',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(height: 20),
          new ModuleAnswerField(
              title: 'Coba kemukakan pendapatmu!',
              textController: firstController),
          menteeID != null
              ? new ModuleGradeField(textController: firstAnswerController)
              : Container(),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Text('Bagian 4',
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
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text('Bagian 4',
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
              height: 30,
            ),
          ],
        ));
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '16');
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
        await UserRepository.getUserAnswers('1', id!, '16');
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
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/1/page/17'))),
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

  @override
  void dispose() {
    firstController.dispose();
    super.dispose();
  }
}

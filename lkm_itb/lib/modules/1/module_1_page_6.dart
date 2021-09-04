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
import 'package:lkm_itb/modules/1/module_1_page_7.dart';

// ignore: must_be_immutable
class Modul1Page6 extends StatefulWidget {
  Modul1Page6(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);

  final String title;
  final String role;
  static const routeName = '/module/1/page/6';
  String? menteeID;

  @override
  _Modul1Page6State createState() => _Modul1Page6State(role, menteeID);
}

class _Modul1Page6State extends State<Modul1Page6> {
  final String role;
  String? menteeID;
  TextEditingController firstController = TextEditingController(text: "");
  TextEditingController firstAnswerController = TextEditingController(text: "");
  bool isLoading = false;
  _Modul1Page6State(this.role, this.menteeID);

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.addModuleGrades(
                "1", "6", listGrades, menteeID!, sharedPrefs.group)
            .then((value) => Navigator.pushNamed(context, Modul1Page7.routeName,
                arguments: {'menteeID': menteeID}));
      } else {
        List<String> listAnswers = [];
        listAnswers.add(firstController.text);
        await ModuleRepository.addModuleAnswer("1", "6", listAnswers)
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
            'Minta Mentee untuk melihat gambar 3 dan menyimpulkan apa yang sudah didapat ke dalam kotak yang tersedia.',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/modul_1_3.png',
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Gambar 3',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 14, color: ConstColor.blackText),
              ),
            ],
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
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/modul_1_3.png',
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Gambar 3',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 14, color: ConstColor.blackText),
              ),
            ],
          ),
          SizedBox(height: 30),
          ModuleAnswerField(
              title:
                  'Coba lihat gambar tersebut! BERBEDA bukan? Nah, setelah melihat gembar ini, menurut kalian, apa sih pemikiran holistik itu?',
              textController: firstController),
          menteeID != null
              ? ModuleGradeField(textController: firstAnswerController)
              : Container()
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
        Text('Bagian 1',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 40,
        ),
        _contentMentor(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        )
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
            )
          ],
        ));
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '6');
      if (userGrade.exists) {
        var listString = List.from(userGrade.get('grades'));
        setState(() {
          firstAnswerController.text =
              listString[0] != null ? listString[0].toString() : '';
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer =
        await UserRepository.getUserAnswers('1', id!, '6');
    if (userAnswer.exists) {
      var listString = List.from(userAnswer.get('answers'));
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
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: <Widget>[
            role == 'mentor' ? _forMentor() : _forMentee(),
            Positioned(
                bottom: 70,
                child: CustomModuleButton(
                    pushFunction: () => pushFunction('/module/1/page/7'))),
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

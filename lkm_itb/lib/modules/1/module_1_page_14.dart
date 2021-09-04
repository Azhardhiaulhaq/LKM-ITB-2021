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
import 'package:lkm_itb/modules/1/module_1_page_16.dart';

// ignore: must_be_immutable
class Modul1Page14 extends StatefulWidget {
  Modul1Page14(
      {Key? key, required this.title, required this.role, this.menteeID})
      : super(key: key);

  final String title;
  final String role;
  static const routeName = '/module/1/page/14';
  String? menteeID;

  @override
  _Modul1Page14State createState() => _Modul1Page14State(role, menteeID);
}

class _Modul1Page14State extends State<Modul1Page14> {
  final String role;
  String? menteeID;
  TextEditingController firstController = TextEditingController(text: "");
  TextEditingController secondController = TextEditingController(text: "");
  TextEditingController firstAnswerController = TextEditingController(text: "");
  TextEditingController secondAnswerController =
      TextEditingController(text: "");
  bool isLoading = false;

  _Modul1Page14State(this.role, this.menteeID);

  _article() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Konflik Hamas dan Fattah',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            'Sumber : CNN Indonesia',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/hammas.png',
            fit: BoxFit.fill,
          ),
          SizedBox(height: 15),
          Text(
            'Jauh sebelum kesepakatan damai terjadi pada tahun 2017, Hamas dan Fatah tak pernah akur kurang lebih sepuluh tahun terakhir. Hamas merebut Gaza dari Fatah dalam sebuah perang saudara yang terjadi sekitar tahun 2007. Sejak itu, kedua faksi terus berselisih. Beberapa upaya rekonsiliasi dilakukan kedua belah pihak, terutama dengan Mesir yang menjadi mediatornya. Namun semuanya berujung kegagalan.',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15),
          Text(
            'Selama konflik Hamas dan Fatah terjadi, Mesir juga meningkatkan keamanan di Semenanjung Sinai yang berbatasan dengan Gaza, tempat pemberontak jihad melakukan perlawanannya. Konflik Hamas-Fatah kerap disebut juga sebagai Perang Saudara Palestina. Sebelum 2007, kedua faksi sudah terlibat ketegangan pada 2006 dan 2005. Ketegangan antara Hamas dan Fatah mulai meningkat pada 2005 setelah kematian pemimpin lama Palestina Yasser Arafat yang meninggal pada 11 November 2004. Ketegangan Hamas dan Fatah kembali intensif setelah Hamas memenangkan pemilihan umum 2006.',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15),
          Text(
            'Perang keduanya pecah pada 2007. Mayoritas peperangan terjadi di Jalur Gaza, dimana kemudian Hamas menguasai kawasan tersebut. Hamas dan Fatah memang berbeda pandangan dalam menyikapi perlawanan terhadap Israel. Beberapa kali gap antara Hamas dan Fatah terlihat. Misalnya Fatah menolak perlawanan bersenjata terhadap Israel yang bertolak belakang dengan Hamas yang kerap melepaskan roket dan misil ketika perang melawan Israel.',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15),
          Text(
            'Fatah juga masuk dalam kompromi terkait masalah Al-Quds. Bahkan Fatah kerap mendorong Mesir agak membawa pasukan militernya masuk ke Jalur Gaza. Fatah juga menghabisi gerakan Hamas di Tepi Barat, mempromosikan kerjasama keamanan dengan Israel, mendapatkan dana dari UE dan sebagian negara Arab. Di satu sisi, Hamas berpegang teguh pandangannya selama ini. Hamas memegang keyakinan terhadap semua wilayah di Palestina dalam satu keutuhan dan menolak mengakui keberadaan Israel. Untuk itu, Hamas memilih caranya sendiri, yakni mengangkat senjata dan berperang melawan Israel demi keutuhan kesatuan wilayah Palestina.',
            style: GoogleFonts.roboto(
                color: ConstColor.whiteBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        listGrades.add(int.parse(secondAnswerController.text));
        await ModuleRepository.addModuleGrades(
                "1", "14", listGrades, menteeID!, sharedPrefs.group)
            .then((value) => Navigator.pushNamed(
                context, Modul1Page16.routeName,
                arguments: {'menteeID': menteeID}));
      } else {
        List<String> listAnswers = [];
        listAnswers.add(firstController.text);
        listAnswers.add(secondController.text);
        await ModuleRepository.addModuleAnswer("1", "14", listAnswers)
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
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Minta mentee membaca secara bergantian dan setiap orang menjawab pertanyaan yang tertera!',
                style: GoogleFonts.roboto(
                    color: ConstColor.blackText,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: _article())),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Coba bacalah narasi berikut!',
                style: GoogleFonts.roboto(
                    color: ConstColor.blackText,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: _article())),
          SizedBox(
            height: 40,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dari narasi tersebut, coba kemukakan pendapatmu!',
                    style: GoogleFonts.roboto(
                        color: ConstColor.blackText,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ModuleAnswerField(
                      title: 'Penyebab masalah terjadi:',
                      textController: firstController),
                  menteeID != null
                      ? ModuleGradeField(textController: firstAnswerController)
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  ModuleAnswerField(
                      title: 'Solusi terhadap masalah:',
                      textController: secondController),
                  menteeID != null
                      ? ModuleGradeField(textController: secondAnswerController)
                      : Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              )),
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
        Text('Bagian 3',
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
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Text('Bagian 3',
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
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  _initAnswer() async {
    if (menteeID != null) {
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade('1', menteeID!, '14');
      if (userGrade.exists) {
        var listString = List.from(userGrade.get('grades'));
        print(listString);
        setState(() {
          firstAnswerController.text =
              listString[0] != null ? listString[0].toString() : '';
          secondAnswerController.text =
              listString[1] != null ? listString[1].toString() : '';
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer =
        await UserRepository.getUserAnswers('1', id!, '14');
    if (userAnswer.exists) {
      var listString = List.from(userAnswer.get('answers'));
      print(listString);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        role == 'mentor' ? _forMentor() : _forMentee(),
        Positioned(
            bottom: 70,
            child: CustomModuleButton(
                pushFunction: () => pushFunction('/module/1/page/15'))),
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

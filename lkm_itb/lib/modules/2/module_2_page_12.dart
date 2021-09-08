import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/components/module_answer_field.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/components/module_grade_field.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/modules/2/module_2_page_14.dart';
import 'package:lkm_itb/modules/2/module_2_page_18.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Modul2Page12 extends StatefulWidget {
  Modul2Page12({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/12';
  int module = 2;
  int page = 12;
  String? menteeID;

  @override
  _Modul2Page12State createState() =>
      _Modul2Page12State(role, module, page, menteeID);
}

class _Modul2Page12State extends State<Modul2Page12> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  TextEditingController firstController = TextEditingController(text: "");
  TextEditingController firstAnswerController = TextEditingController(text: "");

  _Modul2Page12State(this.role, this.module, this.page, this.menteeID);

  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.initiateModuleGrades(
                module.toString(), menteeID!)
            .then((value) async {
          await ModuleRepository.addModuleGrades(module.toString(),
                  page.toString(), listGrades, menteeID!, sharedPrefs.group)
              .then((value) {
                Navigator.pushNamed(context, Modul2Page14.routeName,
                arguments: {'menteeID': menteeID});
              });
        });
      } else {
        List<String> listAnswers = [];
        listAnswers.add(firstController.text);
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), listAnswers)
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

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          Text(
            'Perhatikan diagram berikut ini! ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          _image('assets/images/modul_2_12.png'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Gambar 4',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          new ModuleAnswerField(
              title:
                  'Apakah kamu tahu diagaram apakah ini? Jelaskan apa yang kamu dapat dari diagram ini!',
              textController: firstController),
          menteeID != null
              ?new  ModuleGradeField(textController: firstAnswerController)
              : Container(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
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
          Text(
            'Arahkan Mentee untuk memperhatikan dua gambar berikut ini dan mengisi bagian isian panjang yang tersedia',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          _image('assets/images/modul_2_12.png'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Gambar 4',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
  }

  _image(String path) {
    return Image.asset(
      path,
      height: 300,
      fit: BoxFit.fill,
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
    DocumentSnapshot userAnswer = await UserRepository.getUserAnswers(
        module.toString(), id!, page.toString());
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
                    child: Text('Bagian 3',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: role == 'mentor' ? _forMentor() : _forMentee()),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/13'))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

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
import 'package:lkm_itb/modules/5/module_5_page_8.dart';

// ignore: must_be_immutable
class Modul5Page7 extends StatefulWidget {
  Modul5Page7({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/5/page/7';
  String? menteeID;

  @override
  _Modul5Page7State createState() => _Modul5Page7State(role, menteeID);
}

class _Modul5Page7State extends State<Modul5Page7> {
  final String role;
  String? menteeID;
  bool isLoading = false;
  int module = 5;
  int page = 7;

  _Modul5Page7State(this.role, this.menteeID);

  List<String> listAnswer = ['', '', ''];
  TextEditingController firstAnswerController =
      TextEditingController(text: "0");
  List<String> listTitle = [
    'Character Building',
    'Character Enabling',
    'Character Engineering',
  ];

  List<String> listQuestion = [
    'Memberikan pemaparan di forum atau konferensi internasional tentang budaya ramah tamah Indonesia',
    'Ikut serta dalam organisasi yang menyuarakan cinta damai dan rela berkorban untuk tanah air',
    'Selalu ingat kampung halaman meski sudah bekerja atau belajar di negeri orang',
  ];

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        listGrades.add(int.parse(firstAnswerController.text));
        await ModuleRepository.addModuleGrades(module.toString(),
                page.toString(), listGrades, menteeID!, sharedPrefs.group)
            .then((value) {
          Navigator.pushNamed(context, Modul5Page8.routeName,
              arguments: {'menteeID': menteeID});
        });
      } else {
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), listAnswer)
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
    firstAnswerController.dispose();
    super.dispose();
  }

  Widget _dragTarget(String text, int answerIndex, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 5,
        ),
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
        Text(
          title,
          style: GoogleFonts.roboto(
              color: ConstColor.whiteBackground,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        )
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
              data: 'Character building',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Character building',
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
                        'Character building',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground, fontSize: 16),
                      ))),
            ),
            Draggable<String>(
              // Data is the value this Draggable stores.
              data: 'Character Enabling',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Character Enabling',
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
                        'Character Enabling',
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
              data: 'Character Engineering',
              feedback: Card(
                  color: ConstColor.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Character Engineering',
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
                        'Character Engineering',
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
                      for (var i = 0; i < 3; i++)
                        _dragTarget(listTitle[i], i, listQuestion[i]),
                    ],
                  ),
                ),
              )),
          menteeID != null
              ? new ModuleGradeField(textController: firstAnswerController)
              : Container()
        ],
      ),
    );
  }

  _forMentee() {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.1,
        ),
        Text(
          'Cocokkanlah pasangan proses dan aktivitas berikut!',
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
        _contentMentee(),
        SizedBox(
          height: SizeConfig.screenHeight * 0.3,
        )
      ],
    );
  }

  Widget _dragTargetMentor(String text, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 5,
        ),
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
                      color: ConstColor.blackText, fontSize: 16),
                ))),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: GoogleFonts.roboto(
              color: ConstColor.whiteBackground,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  _contentMentor() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
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
                      for (var i = 0; i < 3; i++)
                        _dragTargetMentor(listTitle[i], listQuestion[i]),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Text(
            'Minta mentee mencocokkan kira kira mana yang merupakan pasangan kategori proses dan aktivitas dalam pengembangan karakter nasionalisme!',
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
          _contentMentor(),
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
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: IntrinsicHeight(
                    child: Stack(alignment: Alignment.center, children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
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
                pushFunction: () => pushFunction('/module/5/page/8'))),
        new LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

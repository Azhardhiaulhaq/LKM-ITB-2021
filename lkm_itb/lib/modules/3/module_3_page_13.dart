import 'package:another_flushbar/flushbar.dart';
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
import 'package:lkm_itb/modules/3/module_3_page_16.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class Modul3Page13 extends StatefulWidget {
  Modul3Page13({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/13';
  int module = 3;
  int page = 13;
  String? menteeID;

  @override
  _Modul3Page13State createState() =>
      _Modul3Page13State(role, module, page, menteeID);
}

class _Modul3Page13State extends State<Modul3Page13> {
  final String role;
  final int module;
  final int page;
  String? menteeID;
  bool isLoading = false;
  List<TextEditingController> answerController = [];
  List<TextEditingController> gradeController = [];
  // ignore: non_constant_identifier_names
  String youtube_link = 'https://www.youtube.com/watch?v=nCFQF2Iyrss';
  late YoutubePlayerController _youtubeController;

  _Modul3Page13State(this.role, this.module, this.page, this.menteeID);

  // ignore: non_constant_identifier_names
  Widget _videoModule(String youtube_link) {
    String? videoID = YoutubePlayer.convertUrlToId(youtube_link) != null
        ? YoutubePlayer.convertUrlToId(youtube_link)
        : '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: ConstColor.darkGreen,
              progressColors: ProgressBarColors(
                  playedColor: ConstColor.darkGreen,
                  handleColor: ConstColor.lightGreen),
            ),
          )),
    );
  }

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route, BuildContext context) async {
    _youtubeController.pause();
    if (role == 'mentee') {
      setState(() {
        isLoading = true;
      });
      if (menteeID != null) {
        List<int> listGrades = [];
        gradeController.forEach((element) {
          listGrades.add(int.parse(element.text));
        });
        await ModuleRepository.initiateModuleGrades(
                module.toString(), menteeID!)
            .then((value) async {
          await ModuleRepository.addModuleGrades(module.toString(),
                  page.toString(), listGrades, menteeID!, sharedPrefs.group)
              .then((value) {
            Navigator.pushNamed(context, Modul3Page16.routeName,
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
        List<String> listAnswers = [];
        answerController.forEach((element) {
          listAnswers.add(element.text);
        });
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), listAnswers)
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

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Yuk simak video berikut dengan seksama!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          _videoModule(youtube_link),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Sumber : Warunk Kopi Youtube Channel',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: ConstColor.blackText,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 50,
          ),
          new ModuleAnswerField(
              title:
                  'Menurutmu, mengapa Singapura bisa maju begitu pesat dalam kurun waktu yang singkat?',
              textController: answerController[0]),
          menteeID != null
              ? new ModuleGradeField(textController: gradeController[0])
              : Container(),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
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
            'Minta Mentee untuk menonton kembali video yang tersedia, kemudian berilah penjelasan mengenai video tersebut!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          _videoModule(youtube_link),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Sumber : Warunk Kopi Youtube Channel',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: ConstColor.blackText,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              )),
          SizedBox(
            height: 50,
          ),
          Text(
            'Dari video itu minta Mentee menjawab pertanyaan yang tersedia!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
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
          for (var i = 0; i < listString.length; i++) {
            gradeController[i].text = listString[i].toString();
          }
        });
      }
    }
    String? id = menteeID != null ? menteeID : sharedPrefs.userid;
    DocumentSnapshot userAnswer = await UserRepository.getUserAnswers(
        module.toString(), id!, page.toString());
    if (userAnswer.exists) {
      var listString = List.from(userAnswer.get('answers'));
      setState(() {
        for (var i = 0; i < listString.length; i++) {
          answerController[i].text = listString[i] != null ? listString[i] : '';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gradeController.add(TextEditingController(text: '0'));
    answerController.add(TextEditingController(text: ""));

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
        new LoadingProgress(isLoading: isLoading),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () =>
                    pushFunction('/module/3/page/14', context))),
      ],
    ));
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    answerController.forEach((element) {
      element.dispose();
    });
    gradeController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }
}

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

class Modul2Page22 extends StatefulWidget {
  Modul2Page22({Key? key, required this.role, this.menteeID}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/22';
  int module = 2;
  int page = 22;
  String? menteeID;

  @override
  _Modul2Page22State createState() =>
      _Modul2Page22State(role, module, page, menteeID);
}

class _Modul2Page22State extends State<Modul2Page22> {
  final String role;
  Map<int, List<String>> mapQuestions = Map();
  TextEditingController firstAnswerController = TextEditingController(text: "");
  int module = 2;
  int page = 22;
  String? menteeID;
  List<String> answers = [
    'Perjanjian',
    'Kebanggaan organisasi',
    '2016, Sasana Budaya Ganesha'
  ];
  List<String> questions = [
    '1. Budaya organisasi merupakan …… bersama tentang nilai-nilai bersama dalam kehidupan organisasi dan mengikat semua orang dalam organisasi yang bersangkutan (Siagian,1995:126).',
    '2. Manakah dibawah ini yang merupakan sebuah output dari konsekuensi hadirnya budaya organisasi?',
    '3. Pada gambar yang telah kamu lihat sebelumnya, Orasi Pelangi OSKM ITB tersebut dilaksanakan kapan dan dimana?'
  ];
  bool isLoading = false;
  _Modul2Page22State(this.role, this.module, this.page, this.menteeID);

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
              .then((value) {});
        });
      } else {
        await ModuleRepository.addModuleAnswer(
                module.toString(), page.toString(), answers)
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
    return Column(
      children: <Widget>[
        for (String data in list)
          new LabeledRadio(
              label: data,
              padding: EdgeInsets.symmetric(horizontal: 5),
              groupValue: answers[index],
              value: data,
              onChanged: (String? value) {
                setState(() {
                  answers[index] = value ?? '';
                  print(answers);
                });
              },
              activeColor: ConstColor.lightGreen)
      ],
    );
  }

  _forMentor() {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Setelah penjelasan mengenai budaya organisasi tadi, arahkan Mentee untuk mengisi beberapa pertanyaan pilihan ganda yang tertera pada layar.',
        style: GoogleFonts.roboto(
          fontSize: 22,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Wah sangat informatif bukan? Pastinya!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Bagian selanjutnya ada sesi knowledge check. Yuk jawab beberapa pertanyaan pilihan ganda berikut ini dengan sebaik-baiknya ya! ',
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
          for (var i = 0; i < questions.length; i++)
            _question(questions[i], mapQuestions.values.elementAt(i), i),
          SizedBox(
            height: 10,
          ),
          menteeID != null
              ? ModuleGradeField(textController: firstAnswerController)
              : Container(),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    List<String> firstQuestions = [
      'Perjanjian',
      'Komitmen',
      'Pergaulan',
      'Hubungan',
      'Pemikiran'
    ];
    List<String> secondQuestions = [
      'Kebanggaan organisasi',
      'Filosofis organisasi',
      'Identitas organisasi',
      'Pedoman normatif organisasi',
      'Visi & misi organisasi'
    ];
    List<String> thirdQuestions = [
      '2016, Sasana Budaya Ganesha',
      '2017, Sarana Budaya Ganesha',
      '2017, Sasana Budaya Ganesha',
      '2018, Sarana Budaya Ganesha',
      '2018, Sasana Budaya Ganesha'
    ];
    mapQuestions[0] = firstQuestions;
    mapQuestions[1] = secondQuestions;
    mapQuestions[2] = thirdQuestions;
    print(mapQuestions);
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
                    child: Text('Bagian 5',
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
                          children: [role == 'mentor' ? _forMentor() : _forMentee()])),
                ])))),
        Positioned(
            bottom: 70,
            child: CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/23'))),
        LoadingProgress(isLoading: isLoading),
      ],
    ));
  }
}

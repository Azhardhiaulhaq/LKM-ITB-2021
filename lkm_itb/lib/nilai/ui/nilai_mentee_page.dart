import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/models/nilai.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';

class NilaiMenteePage extends StatefulWidget {
  NilaiMenteePage({
    Key? key,
    required this.menteeID,
  }) : super(key: key);
  final String menteeID;

  @override
  _NilaiMenteePageState createState() => _NilaiMenteePageState(menteeID);
}

class _NilaiMenteePageState extends State<NilaiMenteePage> {
  final String menteeID;
  bool isLoading = true;
  List<Nilai> listNilaiModule = [];
  String menteeName = '';

  _NilaiMenteePageState(this.menteeID);

  @override
  void initState() {
    super.initState();
  }



  _menteeName(String name) {
    return Text('Berikut adalah total nilai Mentee\n' + name.toUpperCase(),
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(fontSize: 16, color: ConstColor.greyText));
  }

  Widget _modulePoint(String modul, int nilai) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(modul,
            style:
                GoogleFonts.roboto(fontSize: 10, color: ConstColor.darkGreen)),
        SizedBox(
          height: 3,
        ),
        Text(
          nilai.toString(),
          style: GoogleFonts.roboto(
              fontSize: 12, color: ConstColor.whiteBackground),
        )
      ],
    );
  }

  Widget _groupPointCard(List<Nilai> listModule) {
    int totalNilai = 0;
    for (var nilai in listModule) {
      totalNilai = totalNilai + nilai.totalNilai;
    }
    return Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ConstColor.lightGreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    color: ConstColor.darkGreen,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total Nilai ',
                            style: GoogleFonts.roboto(
                                color: ConstColor.whiteBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 20)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(totalNilai.toString() + ' Poin',
                            style: GoogleFonts.roboto(
                                color: ConstColor.whiteBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    color: ConstColor.lightGreen,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (Nilai data in listModule)
                                _modulePoint(
                                    'Modul ' + data.ID, data.totalNilai)
                            ],
                          ),
                        ]))
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<NilaiBloc, NilaiState>(listener: (context, state) {
      if (state is NilaiLoadFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: 'Failed to load this page',
          titleColor: Colors.white,
          message: state.message,
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: ConstColor.invalidEntry,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
      if (state is NilaiLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is NilaiLoadMenteeSuccess) {
        setState(() {
          isLoading = false;
          listNilaiModule = state.listNilaiModule;
          menteeName = state.userName;
        });
      }
    }, child: BlocBuilder<NilaiBloc, NilaiState>(builder: (context, state) {
      return Scaffold(
          body: SafeArea(
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: <Widget>[
              SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.025,
                  ),
                  new CustomBackButton(title: 'Cek Nilai Mentee',),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  _menteeName(menteeName),
                  _groupPointCard(listNilaiModule),
                ],
              )),
              new LoadingProgress(isLoading: isLoading),
            ]),
      ));
    }));
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/models/penilaian_modul.dart';
import 'package:lkm_itb/penilaian_modul/bloc/penilaian_bloc.dart';
import 'package:lkm_itb/penilaian_modul/ui/penilaian_card.dart';

class PenilaianModulePage extends StatefulWidget {
  PenilaianModulePage({Key? key, required this.group, required this.module})
      : super(key: key);
  final String group;
  final Module module;

  @override
  _PenilaianModulePageState createState() =>
      _PenilaianModulePageState(group, module);
}

class _PenilaianModulePageState extends State<PenilaianModulePage> {
  final String group;
  final Module module;
  bool isLoading = true;
  List<PenilaianModul> listPenilaianModules = [];

  _PenilaianModulePageState(this.group, this.module);

  @override
  void initState() {
    super.initState();
  }


  Widget emptyMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/icon_message.png'),
        Text(
            'Tugas kamu belum ada nih, tapi tenang kami nanti kabarin kamu kalo udah kok',
            style: GoogleFonts.roboto(
                fontSize: 16,
                color: ConstColor.blackText,
                fontWeight: FontWeight.normal))
      ],
    );
  }

  Widget _modulInfo() {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
            color: ConstColor.lightGreen,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Modul ' +
                          module.modulID.toString() +
                          ' - ' +
                          module.name.toString(),
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: ConstColor.whiteBackground,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: ConstColor.whiteBackground,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Penilaian Kelompok ' + group,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: ConstColor.whiteBackground,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PenilaianBloc, PenilaianState>(listener:
        (context, state) {
      if (state is PenilaianLoadFailed) {
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
      if (state is PenilaianLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is PenilaianLoadSuccess) {
        setState(() {
          isLoading = false;
          listPenilaianModules = state.listPenilaian;
        });
      }
    }, child:
        BlocBuilder<PenilaianBloc, PenilaianState>(builder: (context, state) {
      return Scaffold(
          body: SafeArea(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              new CustomBackButton(title : 'Capaian'),
              _modulInfo(),
              SizedBox(
                height: 10,
              ),
              for (var list in listPenilaianModules)
                new PenilaianCard(penilaian: list, moduleID: module.modulID!)
            ],
          )),
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
    }));
  }
}

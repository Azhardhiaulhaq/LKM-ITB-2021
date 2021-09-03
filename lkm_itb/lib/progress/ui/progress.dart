import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/progress/bloc/progress_bloc.dart';
import 'package:lkm_itb/progress/ui/progress_card.dart';

class Progress extends StatefulWidget {
  Progress({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  _ProgressState createState() => _ProgressState(status);
}

class _ProgressState extends State<Progress> {
  final String status;
  bool isLoading = true;
  List<Module> listProgressModules = [];
  List<Module> listCompleteModules = [];

  _ProgressState(this.status);

  @override
  void initState() {
    super.initState();
  }

  Widget _emptyProgress() {
    return Container(height: MediaQuery.of(context).size.height*0.5,child:Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/icon_message.png'),
        SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Tugas kamu belum ada nih, tapi tenang kami nanti kabarin kamu kalo udah kok',
              style:
                  GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
              textAlign: TextAlign.center,
            ))
      ],
    )));
  }

  Widget _listProgress() {
    if (status == 'progress') {
      return listProgressModules.isEmpty
          ? _emptyProgress()
          : Column(children: [
              for (var progressModule in listProgressModules)
                new ProgressCard(module: progressModule)
            ]);
    } else {
      return listCompleteModules.isEmpty
          ? _emptyProgress()
          : Column(children: [
              for (var completeModule in listCompleteModules)
                new ProgressCard(module: completeModule)
            ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProgressBloc, ProgressState>(
        listener: (context, state) {
      if (state is ProgressLoadFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: 'Failed to load presence',
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
      if (state is ProgressLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is ProgressLoadSuccess) {
        setState(() {
          isLoading = false;
          listCompleteModules = state.listCompleteModules;
          listProgressModules = state.listProgressModules;
        });
      }
    }, child:
            BlocBuilder<ProgressBloc, ProgressState>(builder: (context, state) {
      return Scaffold(
          body: SafeArea(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[_listProgress()],
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

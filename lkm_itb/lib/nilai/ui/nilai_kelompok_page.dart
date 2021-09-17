import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/models/nilai_mentee.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';
import 'package:lkm_itb/nilai/ui/nilai_kelompok_card.dart';

class NilaiKelompokPage extends StatefulWidget {
  NilaiKelompokPage({
    Key? key,
    required this.group,
  }) : super(key: key);
  final String group;

  @override
  _NilaiKelompokPageState createState() => _NilaiKelompokPageState(group);
}

class _NilaiKelompokPageState extends State<NilaiKelompokPage> {
  final String group;
  bool isLoading = true;
  List<NilaiMentee> listNilaiMentee = [];

  _NilaiKelompokPageState(this.group);

  @override
  void initState() {
    super.initState();
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
      if (state is NilaiLoadKelompokSuccess) {
        setState(() {
          isLoading = false;
          listNilaiMentee = state.listNilaiMentee;
        });
      }
    }, child: BlocBuilder<NilaiBloc, NilaiState>(builder: (context, state) {
      return Scaffold(
          body: SafeArea(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenHeight * 0.025,
              ),
              new CustomBackButton(title: 'Cek Nilai Kelompok'),
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              for (var list in listNilaiMentee)
                new NilaiKelompokCard(penilaian: list),
              SizedBox(
                height: SizeConfig.screenHeight * 0.2,
              ),
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

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/models/nilai_mentee.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';
import 'package:lkm_itb/nilai/ui/nilai_kelompok_card.dart';


class NilaiKelompokPage extends StatefulWidget {
  NilaiKelompokPage({Key? key, required this.group, })
      : super(key: key);
  final String group;


  @override
  _NilaiKelompokPageState createState() =>
      _NilaiKelompokPageState(group);
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

  Widget _backButton() {
    return Material(
        child: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.arrow_back, color: ConstColor.lightGreen),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Cek Nilai Kelompok',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ConstColor.blackText))
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<NilaiBloc, NilaiState>(listener:
        (context, state) {
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
    }, child:
        BlocBuilder<NilaiBloc, NilaiState>(builder: (context, state) {
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
              _backButton(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              for (var list in listNilaiMentee)
                new NilaiKelompokCard(penilaian: list),
              SizedBox(
                height: SizeConfig.screenHeight * 0.12,
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

import 'package:another_flushbar/flushbar.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/models/nilai.dart';
import 'package:lkm_itb/data/repositories/nilai_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';
import 'package:lkm_itb/nilai/ui/nilai_kelompok_screen.dart';
import 'package:lkm_itb/nilai/ui/nilai_mentee_screen.dart';
import 'package:open_file/open_file.dart';

class NilaiPage extends StatefulWidget {
  NilaiPage(
      {Key? key, required this.group, required this.name, required this.role})
      : super(key: key);
  final String group;
  final String name;
  final String role;

  @override
  _NilaiPageState createState() => _NilaiPageState(group, name, role);
}

class _NilaiPageState extends State<NilaiPage> {
  final String group;
  final String name;
  final String role;
  int nilaiGroup = 0;
  bool isLoading = true;
  List<Nilai> listNilaiModule = [];
  List<Nilai> listNilaiKelompok = [];

  _NilaiPageState(this.group, this.name, this.role);

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

  Widget _klasementTitle() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: SizeConfig.screenWidth,
            color: ConstColor.lightGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Klasemen Nilai Kelompok',
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: ConstColor.blackText)),
              ],
            ),
          ),
        ));
  }

  Widget _groupPointCard(int nilaiGroup) {
    return Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: SizeConfig.screenWidth,
            color: ConstColor.lightGreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.all(15),
                    color: ConstColor.darkGreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Nilai Kelompok ' + group + ' saat ini',
                            style: GoogleFonts.roboto(
                                color: ConstColor.whiteBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(nilaiGroup.toString() + ' Poin',
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
                              for (Nilai data in listNilaiModule)
                                _modulePoint(
                                    'Modul ' + data.ID, data.totalNilai)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              child: Text(
                                  sharedPrefs.role == 'mentor'
                                      ? 'Cek Nilai Kelompok ' + group.toString()
                                      : 'Cek Nilai Saya',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: ConstColor.darkGreen,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  )),
                              onTap: () {
                                if (sharedPrefs.role == 'mentor') {
                                  Navigator.pushNamed(
                                      context, NilaiKelompokScreen.routeName,
                                      arguments: {'group': group});
                                } else {
                                  Navigator.pushNamed(
                                      context, NilaiMenteeScreen.routeName,
                                      arguments: {
                                        'menteeID': sharedPrefs.userid
                                      });
                                }
                              })
                        ]))
              ],
            ),
          ),
        ));
  }

  _klasemen(Nilai nilai, int index) {
    double size = 14;
    switch (index) {
      case 1:
        size = 20;
        break;
      case 2:
        size = 18;
        break;
      case 3:
        size = 16;
        break;
      default:
        size = 14;
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Kelompok ' + nilai.ID,
              style: GoogleFonts.roboto(
                  fontSize: size, color: ConstColor.blackText)),
          Text(nilai.totalNilai.toString(),
              style: GoogleFonts.roboto(
                  fontSize: size, color: ConstColor.blackText))
        ],
      ),
    );
  }

  void _createExcel() async {
    setState(() {
      isLoading = true;
    });
    await NilaiRepository.downloadGrades(sharedPrefs.group).then((value) {
      new Flushbar(
        title: 'Download Selesai',
        titleColor: Colors.white,
        message: 'Proses Download Selesai. File terdapat pada folder Download',
        messageColor: Colors.white,
        duration: Duration(seconds: 3),
        backgroundColor: ConstColor.lightGreen,
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        leftBarIndicatorColor: Colors.blue[300],
      )..show(context);
      OpenFile.open(value);
    });
    setState(() {
      isLoading = false;
    });
  }

  Widget _downloadButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _createExcel();
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: ConstColor.lightGreen,
              child: Text('Unduh Nilai Kelompok',
                  style: GoogleFonts.roboto(
                      color: ConstColor.whiteBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 16)),
            ),
          )),
    );
  }

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
      if (state is NilaiLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is NilaiLoadSuccess) {
        setState(() {
          isLoading = false;
          listNilaiModule = state.listNilaiModule;
          listNilaiKelompok = state.listNilaiKelompok;
          if (listNilaiKelompok.length >= int.parse(group)) {
            nilaiGroup = listNilaiKelompok[int.parse(group) - 1].totalNilai;
          }
          listNilaiKelompok = listNilaiKelompok.sublist(0, 20);
          listNilaiKelompok
              .sort((a, b) => b.totalNilai.compareTo(a.totalNilai));
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
                height: SizeConfig.screenHeight * 0.03,
              ),
              Text('Hai, ' + name.toUpperCase(),
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: ConstColor.blackText,
                      fontWeight: FontWeight.w500)),
              _groupPointCard(nilaiGroup),
              role == 'mentor' ? _downloadButton(context) : Container(),
              _klasementTitle(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              for (var i = 0; i < listNilaiKelompok.length; ++i)
                _klasemen(listNilaiKelompok[i], i + 1),
              SizedBox(
                height: SizeConfig.screenHeight * 0.12,
              ),
            ],
          )),
          new LoadingProgress(isLoading: isLoading),
        ]),
      ));
    }));
  }
}

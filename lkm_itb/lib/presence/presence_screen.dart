import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/presence.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/presence/bloc/presence_bloc.dart';

class PresenceScreen extends StatefulWidget {
  PresenceScreen(
      {Key? key,
      required this.title,
      required this.eventID,
      required this.type})
      : super(key: key);

  final String title;
  final String eventID;
  final String type;

  @override
  _PresenceScreenState createState() => _PresenceScreenState(eventID, type);
}

class _PresenceScreenState extends State<PresenceScreen> {
  final String eventID;
  final String type;
  late String _group;
  String title = '';
  bool isLoading = true;
  List<Presence> listPresence = [];

  _PresenceScreenState(this.eventID, this.type);

  _countKehadiran() {
    var countPresence =
        listPresence.where((c) => c.isPresence == true).toList().length;
    var countTotal = listPresence.length;
    return Text(
      countPresence.toString() + '/' + countTotal.toString(),
      style: GoogleFonts.roboto(
          color: ConstColor.blackText,
          fontSize: 36,
          fontWeight: FontWeight.w700),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _group = sharedPrefs.group;
    });
  }

  _presenceList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: listPresence
          .map((e) => SwitchListTile(
                title: Text(e.name!),
                value: e.isPresence,
                onChanged: (bool value) {
                  setState(() {
                    e.isPresence = !e.isPresence;
                  });
                },
                activeColor: ConstColor.darkGreen,
              ))
          .toList(),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ConstColor.lightGreen),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: ConstColor.darkGreen,
            onTap: () async {
              await PresenceBloc()
                ..add(SavePresence(
                    eventID: eventID,
                    group: _group,
                    listPresence: listPresence));

              if (type == 'module') {
                Navigator.pushNamed(context, '/module/' + eventID + '/page/1');
              }
            },
            child: Container(
                alignment: Alignment.center,
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                child: Text(
                    type == 'module' ? 'Ayo Mentoring!' : 'Simpan Presensi',
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: ConstColor.whiteBackground,
                        fontWeight: FontWeight.w700))),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PresenceBloc, PresenceState>(
        listener: (context, state) {
      if (state is LoadPresenceFailed) {
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
      if (state is PresenceLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is LoadPresenceSuccess) {
        setState(() {
          isLoading = false;
          title = state.title;
          listPresence = state.listPresence;
        });
      }
      if (state is UpdatePresenceSuccess) {
        setState(() {
          isLoading = false;
          Flushbar(
            title: 'Data are saved',
            titleColor: Colors.white,
            message: 'Your precense are recorded',
            messageColor: Colors.white,
            duration: Duration(seconds: 2),
            backgroundColor: ConstColor.lightGreen,
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            reverseAnimationCurve: Curves.decelerate,
            forwardAnimationCurve: Curves.elasticOut,
            leftBarIndicatorColor: Colors.blue[300],
          )..show(context);
        });
      } else if (state is UpdatePresenceFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: 'Failed to save precense',
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
    }, child:
            BlocBuilder<PresenceBloc, PresenceState>(builder: (context, state) {
      return Scaffold(
          body: SafeArea(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              type == 'seminar'
                  ? new CustomBackButton(title: 'Presensi Kelompok')
                  : Container(),
              type == 'module'
                  ? Text(
                      'Sebelum memulai mentoring, jangan lupa untuk mengisi presensi ini ya!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700),
                    )
                  : Container(),
              SizedBox(
                height: 40,
              ),
              type == 'seminar'
                  ? Text(title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700))
                  : Text('Modul ' + eventID + ' - ' + title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: ConstColor.blackText,
                          fontWeight: FontWeight.w700)),
              SizedBox(
                height: 40,
              ),
              _presenceList(),
              SizedBox(
                height: 40,
              ),
              Text('Kehadiran',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: ConstColor.lightGreen,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 20,
              ),
              _countKehadiran(),
              SizedBox(
                height: 20,
              ),
              _saveButton(context),
              SizedBox(
                height: 80,
              )
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

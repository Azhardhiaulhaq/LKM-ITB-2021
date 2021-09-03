import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';
import 'package:lkm_itb/nilai/ui/nilai_mentee_page.dart';

class NilaiMenteeScreen extends StatelessWidget {
  final String menteeID;
  const NilaiMenteeScreen({Key? key, required this.menteeID})
      : super(key: key);
  static const routeName = '/nilai/mentee';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider<NilaiBloc>(
          create: (context) => NilaiBloc()..add(NilaiMenteeLoaded(menteeID)),
          child: NilaiMenteePage(
            menteeID: menteeID,
          )),
    );
  }
}

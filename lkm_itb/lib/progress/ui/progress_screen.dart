import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/progress/bloc/progress_bloc.dart';
import 'package:lkm_itb/progress/ui/progress.dart';

class ProgressScreen extends StatelessWidget {
  final String status;
  final String grup;
  final User user;
  const ProgressScreen({
    Key? key,
    required this.status,
    required this.grup,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider<ProgressBloc>(
          create: (context) {
            print(sharedPrefs.role);
            if (sharedPrefs.role == 'mentor') {
              return ProgressBloc()
                ..add(ProgressMentorLoaded(sharedPrefs.group));
            } else {
              return ProgressBloc()
                ..add(ProgressMenteeLoaded(sharedPrefs.userid));
            }
          },
          child: Progress(
            status: this.status,
          )),
    );
  }
}

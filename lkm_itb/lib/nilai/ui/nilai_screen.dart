import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';
import 'package:lkm_itb/nilai/ui/nilai_page.dart';

class NilaiScreen extends StatelessWidget {
  final String role;
  final String name;
  final String group;
  const NilaiScreen(
      {Key? key, required this.role, required this.group, required this.name})
      : super(key: key);
  static const routeName = '/nilai';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider<NilaiBloc>(
          create: (context) => NilaiBloc()..add(NilaiLoaded(group)),
          child: NilaiPage(name: name, group: group, role: role)),
    );
  }


}

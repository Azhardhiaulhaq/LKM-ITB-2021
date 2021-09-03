import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/nilai/bloc/nilai_bloc.dart';
import 'package:lkm_itb/nilai/ui/nilai_kelompok_page.dart';

class NilaiKelompokScreen extends StatelessWidget {
  final String group;
  const NilaiKelompokScreen({Key? key, required this.group}) : super(key: key);
  static const routeName = '/nilai/kelompok';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider<NilaiBloc>(
          create: (context) => NilaiBloc()..add(NilaiKelompokLoaded(group)),
          child: NilaiKelompokPage(group: group)),
    );
  }
}

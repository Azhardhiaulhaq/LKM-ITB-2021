import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/penilaian_modul/bloc/penilaian_bloc.dart';
import 'package:lkm_itb/penilaian_modul/ui/penilaian_modul_page.dart';


class PenilaianModulScreen extends StatelessWidget{
  final Module module;

 const PenilaianModulScreen({Key? key, required this.module}) :
        super(key: key);

  
  @override
  Widget build(BuildContext context) {
    String grup = sharedPrefs.group;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider<PenilaianBloc>(
        create: (context) => PenilaianBloc()..add(PenilaianLoaded(grup,module)),
        child: PenilaianModulePage(group: grup, module: module)
      ),
    );
  }
  
}
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/presence/bloc/presence_bloc.dart';
import 'package:lkm_itb/presence/presence_screen.dart';

class PresenceBuilder extends StatelessWidget{
  final String eventID;
  final String type;
 const PresenceBuilder({Key? key, required this.eventID, required this.type,}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<PresenceBloc>(
        create: (context) => PresenceBloc()..add(LoadPresence(eventID: eventID,group:sharedPrefs.group,type: type)),
        child: PresenceScreen(title: 'Login Form', eventID: eventID, type : type)
      ),
    );
  }
  
}
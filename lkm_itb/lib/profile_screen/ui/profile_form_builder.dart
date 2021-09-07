import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/profile_screen/bloc/profile_bloc.dart';
import 'package:lkm_itb/profile_screen/ui/profile_edit_form.dart';


class ProfileFormBuilder extends StatelessWidget{
  final User user;
 const ProfileFormBuilder({Key? key, required this.user}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc()..add(loadProfile(user: user)),
        child: ProfileEditForm(title: 'Profile Edit Form', user: user)
      ),
    );
  }
  
}
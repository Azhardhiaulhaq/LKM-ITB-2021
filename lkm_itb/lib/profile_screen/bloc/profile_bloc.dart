import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkm_itb/data/models/profile_data.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
static FirebaseFirestore firestore = FirebaseFirestore.instance;
static CollectionReference grades = firestore.collection('grades');
static CollectionReference groupGrades = firestore.collection('group_grades');
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is loadProfile) {
      yield ProfileLoading();

      try {
        // QuerySnapshot group = await grades.doc('1').collection('groups').get();
        // for (var group in group.docs){
        //   await grades.doc('1').collection('groups').doc(group.id).update({'score' : 0});
        // }
        // QuerySnapshot group = await groupGrades.get();
        // for(var group in group.docs){
        //    await groupGrades.doc(group.id).update({'total' : 0});
        // }
      //  QuerySnapshot users = await grades.doc('1').collection('users').get();
      //  for(var user in users.docs){
      //    var mapUser = user.data() as Map;
      //    String group = mapUser['group'];
      //    String userID = user.id;
      //    QuerySnapshot questions = await grades.doc('1').collection('users').doc(user.id).collection('questions').get();
      //    for(var question in questions.docs){
      //      var mapQuestion = question.data() as Map;
      //      List listGrades = List.from(mapQuestion['grades']);
      //      for(var grade in listGrades){
      //        int score = grade.toInt();
      //         await grades.doc('1').collection('users').doc(userID).update({'score' : FieldValue.increment(score)});
      //         await grades.doc('1').collection('groups').doc(group).update({'score' : FieldValue.increment(score)});
      //         await groupGrades.doc(group).update({'total' : FieldValue.increment(score)});
      //      }
      //    }
      //   //  await grades.doc('1').collection('users').doc(user.id).update({'score' : 0});
      //  }
        DocumentSnapshot user =
            await UserRepository.getUserDetail(event.user.uid);
        if (user.exists) {
          Map dataProfile = user.data() as Map;
          ProfileData profile = ProfileData(
              email: event.user.email!,
              userID: event.user.uid,
              name: dataProfile['name'] ?? '',
              gender: dataProfile['gender'],
              nim: dataProfile['nim'],
              faculty: dataProfile['faculty'],
              major: dataProfile['major'],
              organizationType: dataProfile['organizationType'],
              organization: dataProfile['organization'],
              photo: dataProfile['photo'],
              role: dataProfile['role'],
              group: dataProfile['group']);

          yield ProfileSucceed(profile: profile);

        } else {
          yield ProfileFailed(message: 'User Kosong');
        }
      } catch (e) {
        yield ProfileFailed(message: e.toString());
      }
    } else if (event is updateProfile) {
      yield ProfileLoading();
      try {
        await UserRepository.updateProfile(event.user);

        yield updateProfileSuccess();
      } catch (e) {
        yield updateProfileFailed(message: e.toString());
      }
    } else if(event is uploadImage){
      yield ProfileLoading();
      try{
        var imageLink = await UserRepository.uploadImage(event.imageFile);
        if (imageLink != null){
          await UserRepository.updateImageProfile(imageLink, event.userID);
        }
        yield updateProfileSuccess();
      } catch(e){
        yield updateProfileFailed(message: e.toString());
      }
    }
  }
}

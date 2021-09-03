import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:meta/meta.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressInitial());

  @override
  Stream<ProgressState> mapEventToState(
    ProgressEvent event,
  ) async* {
    if (event is ProgressMentorLoaded) {
      try {
        yield ProgressLoading();
        List<Module> listProgressModules = [];
        List<Module> listCompleteModules = [];

        int lengthGroup = await UserRepository.getGroupLength(event.group);
        List<QueryDocumentSnapshot> listModules =
            await ModuleRepository.getModulesList();
        for (var element in listModules) {
          int lengthAnswer =
              await ModuleRepository.getModulesAnswer(element.id, event.group);
          if (lengthAnswer > 0) {
            int lengthGraded = await ModuleRepository.getGradedUserLength(
                element.id, event.group);
            Module moduleData = Module(
                modulID: element.id,
                banner: element.get('banner'),
                naration: element.get('naration'),
                name: element.get('name'),
                questions: List.from(element.get('questions')));
            if (lengthGraded < lengthGroup) {
              listProgressModules.add(moduleData);
            } else {
              listCompleteModules.add(moduleData);
            }
          }
        }
        yield ProgressLoadSuccess(listProgressModules, listCompleteModules);
      } catch (e) {
        yield ProgressLoadFailed(e.toString());
      }
    } else if (event is ProgressMenteeLoaded) {
      try {
        yield ProgressLoading();
        List<Module> listProgressModules = [];
        List<Module> listCompleteModules = [];

        List<QueryDocumentSnapshot> listModules =
            await ModuleRepository.getModulesList();
        for (var element in listModules) {
          var complete = await ModuleRepository.getUserAnswerStatus(
              element.id, event.userID);
          if (complete != null) {
            Module moduleData = Module(
                modulID: element.id,
                banner: element.get('banner'),
                naration: element.get('naration'),
                name: element.get('name'),
                questions: List.from(element.get('questions')));
            if (complete == false) {
              listProgressModules.add(moduleData);
            } else {
              listCompleteModules.add(moduleData);
            }
          }
        }
        yield ProgressLoadSuccess(listProgressModules, listCompleteModules);
      } catch (e) {
        yield ProgressLoadFailed(e.toString());
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkm_itb/data/models/nilai.dart';
import 'package:lkm_itb/data/models/nilai_mentee.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/nilai_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:meta/meta.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiBloc() : super(NilaiInitial());

  @override
  Stream<NilaiState> mapEventToState(
    NilaiEvent event,
  ) async* {
    if (event is NilaiLoaded) {
      yield NilaiLoading();
      try {
        Map<String, Nilai> mapNilaiModule = {};
        List<Nilai> listNilaiModule = [];
        List<Nilai> listNilaiKelompok = [];
        for (int i = 1; i <= 6; ++i) {
          mapNilaiModule[i.toString()] = Nilai(ID: i.toString(), totalNilai: 0);
        }
        List<QueryDocumentSnapshot> listGradeModules =
            await NilaiRepository.getGradeModules();
        for (var module in listGradeModules) {
          int nilai =
              await ModuleRepository.getModuleGrade(module.id, event.group);
          mapNilaiModule[module.id]!.incrementNilai(nilai);
        }

        List<QueryDocumentSnapshot> listGroupGrade =
            await NilaiRepository.getGroupGrade();
        for (var grade in listGroupGrade) {
          
          var tempGrade = grade.data() as Map;
          print(tempGrade['group']);
          int total = tempGrade['total'];
          listNilaiKelompok
              .add(Nilai(ID: tempGrade['group'], totalNilai: total));
        }

        mapNilaiModule.forEach((key, value) {
          listNilaiModule.add(value);
        });
        yield NilaiLoadSuccess(listNilaiKelompok, listNilaiModule);
      } catch (e) {
        yield NilaiLoadFailed(e.toString());
      }
    } else if (event is NilaiKelompokLoaded) {
      try {
        yield NilaiLoading();
        List<NilaiMentee> listNilaiMentee = [];
        Map<String, NilaiMentee> mapNilaiMentee = {};
        List<QueryDocumentSnapshot> listUserinGroup =
            await UserRepository.getUserinGroup(event.group);

        for (var user in listUserinGroup) {
          mapNilaiMentee[user.get('name')] =
              NilaiMentee(ID: user.id, name: user.get('name'), totalNilai: 0);
        }

        List<QueryDocumentSnapshot> listGradeModules =
            await NilaiRepository.getGradeModules();
        for (var module in listGradeModules) {
          List<QueryDocumentSnapshot> listUsers =
              await NilaiRepository.getGroupedUser(module.id, event.group);
          for (var user in listUsers) {
            Map<String, dynamic> map = user.data() as Map<String, dynamic>;
            mapNilaiMentee[map['name']]!.incrementNilai(map['score'] ?? 0);
          }
        }
        mapNilaiMentee.forEach((key, value) => listNilaiMentee.add(value));
        yield NilaiLoadKelompokSuccess(listNilaiMentee);
      } catch (e) {
        yield NilaiLoadFailed(e.toString());
      }
    } else if (event is NilaiMenteeLoaded) {
      try {
        yield NilaiLoading();
        List<Nilai> listNilaiModule = [];
        for (int i = 1; i <= 6; ++i) {
          int nilai = await UserRepository.getUserTotalGrade(
              i.toString(), event.menteeID);
          listNilaiModule.add(Nilai(ID: i.toString(), totalNilai: nilai));
        }
        DocumentSnapshot userDetail =
            await UserRepository.getUserDetail(event.menteeID);
        String userName = userDetail.get('name');
        yield NilaiLoadMenteeSuccess(userName, listNilaiModule);
      } catch (e) {
        yield NilaiLoadFailed(e.toString());
      }
    }
  }
}

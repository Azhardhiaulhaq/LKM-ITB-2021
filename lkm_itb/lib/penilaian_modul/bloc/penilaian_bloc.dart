import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/models/penilaian_modul.dart';
import 'package:lkm_itb/data/repositories/nilai_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:meta/meta.dart';

part 'penilaian_event.dart';
part 'penilaian_state.dart';

class PenilaianBloc extends Bloc<PenilaianEvent, PenilaianState> {
  PenilaianBloc() : super(PenilaianInitial());

  @override
  Stream<PenilaianState> mapEventToState(
    PenilaianEvent event,
  ) async* {
    if (event is PenilaianLoaded) {
      yield PenilaianLoading();
      try {
        Map<String, PenilaianModul> mapPenilaian = {};
        List<PenilaianModul> listPenilaian = [];

        List<QueryDocumentSnapshot<Object?>> listGroupedUser =
            await UserRepository.getGroupedUser(event.group);
        for (var user in listGroupedUser) {
          mapPenilaian[user.id] = PenilaianModul(
              userID: user.id,
              name: user.get('name'),
              nilai: 0,
              isComplete: false);
        }
        print(mapPenilaian.toString());
        List<QueryDocumentSnapshot> listGradedUsers =
            await NilaiRepository.getGroupedUser(
                event.module.modulID!, event.group);
        for (var user in listGradedUsers) {
          Map<String, dynamic> map = user.data() as Map<String, dynamic>;

          mapPenilaian[user.id]!.incrementNilai(map['score'] ?? 0);
          mapPenilaian[user.id]!.setStatus(map['isComplete'] ?? false);
        }

        mapPenilaian.forEach((key, value) => listPenilaian.add(value));
        yield PenilaianLoadSuccess(listPenilaian: listPenilaian);
      } catch (e) {
        yield PenilaianLoadFailed(message: e.toString());
      }
    }
  }
}

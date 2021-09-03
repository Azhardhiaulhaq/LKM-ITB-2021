import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkm_itb/data/models/presence.dart';
import 'package:lkm_itb/data/repositories/event_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:meta/meta.dart';

part 'presence_event.dart';
part 'presence_state.dart';

class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  PresenceBloc() : super(PresenceInitial());

  @override
  Stream<PresenceState> mapEventToState(
    PresenceEvent event,
  ) async* {
    if (event is LoadPresence) {
      yield PresenceLoading();
      try {
        String title = '';
        List<Presence> listPresence = [];
        List<Presence> listUserID = [];
        List<QueryDocumentSnapshot> groupedUser =
            await UserRepository.getGroupedUser(event.group);
        List<QueryDocumentSnapshot> presenceUser =
            await UserRepository.getPresencedSeminarUser(
                event.eventID, event.group);

        if (event.type != 'module'){
          title = await EventRepository.getSeminarTitle(event.eventID);
        } else {
          title = await EventRepository.getModulTitle(event.eventID);
        }
        

        for (var doc in groupedUser) {
          if (doc.data() != null) {
            var data = doc.data() as Map<String, dynamic>;
            listPresence.add(Presence(
                userID: doc.id, name: data['name'], isPresence: false));
          }
        }

        for (var doc in presenceUser) {
          if (doc.data() != null) {
            var data = doc.data() as Map<String, dynamic>;
            listUserID.add(Presence(userID: doc.id, name: data['name'], isPresence: data['is_precense']));
          }
        }

        for (Presence data in listPresence) {
          var contain = listUserID.where((element) => element.userID == data.userID);
          if (!contain.isEmpty) {
            if(contain.first.isPresence == true){
              data.isPresence = true;
            }
          }
        }
        yield LoadPresenceSuccess(listPresence: listPresence, title: title);
      } catch (e) {
        yield LoadPresenceFailed(message: e.toString());
      }
    } else if (event is SavePresence) {
      yield PresenceLoading();
      try {
        List<String> listUserID = [];
        List<QueryDocumentSnapshot> presenceUser =
            await UserRepository.getPresencedSeminarUser(
                event.eventID, event.group);
        for (var doc in presenceUser) {
          if (doc.data() != null) {
            listUserID.add(doc.id);
          }
        }
        for (Presence data in event.listPresence) {
          if (listUserID.contains(data.userID)) {
            await UserRepository.updatePrecense(
                event.eventID, event.group, data);
          } else {
            await UserRepository.addPrecense(event.eventID, event.group, data);
          }
        }
        yield UpdatePresenceSuccess();
      } catch (e) {
        yield UpdatePresenceFailed(message: e.toString());
      }
    }
  }
}

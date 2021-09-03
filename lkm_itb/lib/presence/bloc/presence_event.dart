part of 'presence_bloc.dart';

@immutable
abstract class PresenceEvent {}

// ignore: must_be_immutable
class LoadPresence extends PresenceEvent {
  String eventID, group,type;
  LoadPresence({required this.eventID, required this.group,required this.type});
}

class SavePresence extends PresenceEvent {
  String eventID, group;
  List<Presence> listPresence;
  SavePresence({required this.eventID, required this.group, required this.listPresence});
}


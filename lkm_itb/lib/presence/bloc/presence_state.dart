part of 'presence_bloc.dart';

@immutable
abstract class PresenceState {}

class PresenceInitial extends PresenceState {}
class PresenceLoading extends PresenceState {}
// ignore: must_be_immutable
class LoadPresenceSuccess extends PresenceState{
  List<Presence> listPresence;
  String title;
  LoadPresenceSuccess({required this.listPresence, required this.title});
}

// ignore: must_be_immutable
class LoadPresenceFailed extends PresenceState{
  String message;
  LoadPresenceFailed({required this.message});
}

class UpdatePresenceSuccess extends PresenceState{

  UpdatePresenceSuccess();
}

// ignore: must_be_immutable
class UpdatePresenceFailed extends PresenceState{
  String message;
  UpdatePresenceFailed({required this.message});
}

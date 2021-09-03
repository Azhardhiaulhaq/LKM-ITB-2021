part of 'presence_bloc.dart';

@immutable
abstract class PresenceState {}

class PresenceInitial extends PresenceState {}
class PresenceLoading extends PresenceState {}
class LoadPresenceSuccess extends PresenceState{
  List<Presence> listPresence;
  String title;
  LoadPresenceSuccess({required this.listPresence, required this.title});
}

class LoadPresenceFailed extends PresenceState{
  String message;
  LoadPresenceFailed({required this.message});
}

class UpdatePresenceSuccess extends PresenceState{

  UpdatePresenceSuccess();
}

class UpdatePresenceFailed extends PresenceState{
  String message;
  UpdatePresenceFailed({required this.message});
}

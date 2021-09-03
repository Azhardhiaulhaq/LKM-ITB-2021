part of 'nilai_bloc.dart';

@immutable
abstract class NilaiEvent {}

class NilaiLoaded extends NilaiEvent {
  final String group;

  NilaiLoaded(this.group);
}

class NilaiKelompokLoaded extends NilaiEvent {
  final String group;

  NilaiKelompokLoaded(this.group);
}

class NilaiMenteeLoaded extends NilaiEvent {
  final String menteeID;

  NilaiMenteeLoaded(this.menteeID);
}

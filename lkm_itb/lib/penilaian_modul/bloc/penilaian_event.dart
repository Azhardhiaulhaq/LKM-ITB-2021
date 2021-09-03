part of 'penilaian_bloc.dart';

@immutable
abstract class PenilaianEvent {}

class PenilaianLoaded extends PenilaianEvent {
  final String group;
  final Module module;

  PenilaianLoaded(this.group, this.module);
}

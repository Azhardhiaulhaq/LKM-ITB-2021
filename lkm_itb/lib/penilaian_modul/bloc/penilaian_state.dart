part of 'penilaian_bloc.dart';

@immutable
abstract class PenilaianState {}

class PenilaianInitial extends PenilaianState {}

class PenilaianLoading extends PenilaianState{}

class PenilaianLoadSuccess extends PenilaianState{
  List<PenilaianModul> listPenilaian;
  PenilaianLoadSuccess({required this.listPenilaian});
}

class PenilaianLoadFailed extends PenilaianState{
  String message;
  PenilaianLoadFailed({required this.message});
}

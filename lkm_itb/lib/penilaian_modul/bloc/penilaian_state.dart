part of 'penilaian_bloc.dart';

@immutable
abstract class PenilaianState {}

class PenilaianInitial extends PenilaianState {}

class PenilaianLoading extends PenilaianState{}

// ignore: must_be_immutable
class PenilaianLoadSuccess extends PenilaianState{
  List<PenilaianModul> listPenilaian;
  PenilaianLoadSuccess({required this.listPenilaian});
}

// ignore: must_be_immutable
class PenilaianLoadFailed extends PenilaianState{
  String message;
  PenilaianLoadFailed({required this.message});
}

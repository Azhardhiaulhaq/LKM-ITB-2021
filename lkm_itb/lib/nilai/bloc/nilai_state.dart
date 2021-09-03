part of 'nilai_bloc.dart';

@immutable
abstract class NilaiState {}

class NilaiInitial extends NilaiState {}

class NilaiLoading extends NilaiState{}

class NilaiLoadSuccess extends NilaiState{
  final List<Nilai> listNilaiKelompok;
  final List<Nilai> listNilaiModule;

  NilaiLoadSuccess(this.listNilaiKelompok,this.listNilaiModule);
  
}

class NilaiLoadMenteeSuccess extends NilaiState{
  final String userName;
  final List<Nilai> listNilaiModule;

  NilaiLoadMenteeSuccess(this.userName,this.listNilaiModule);
  
}

class NilaiLoadKelompokSuccess extends NilaiState{
  final List<NilaiMentee> listNilaiMentee;
  NilaiLoadKelompokSuccess(this.listNilaiMentee);
}

class NilaiLoadFailed extends NilaiState{
  final String message;

  NilaiLoadFailed(this.message);
}
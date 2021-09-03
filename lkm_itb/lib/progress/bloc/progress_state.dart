part of 'progress_bloc.dart';

@immutable
abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState{}

class ProgressLoadSuccess extends ProgressState{
  final List<Module> listProgressModules;
  final List<Module> listCompleteModules;

  ProgressLoadSuccess(this.listProgressModules,this.listCompleteModules);
  
}

class ProgressLoadFailed extends ProgressState{
  final String message;

  ProgressLoadFailed(this.message);
}

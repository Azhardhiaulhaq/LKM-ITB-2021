part of 'progress_bloc.dart';

@immutable
abstract class ProgressEvent {}

class ProgressMentorLoaded extends ProgressEvent {
  final String group;

  ProgressMentorLoaded(this.group);
}

class ProgressMenteeLoaded extends ProgressEvent {
  final String userID;

  ProgressMenteeLoaded(this.userID);
}

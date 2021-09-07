part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
// ignore: must_be_immutable
class ProfileSucceed extends ProfileState {
  ProfileData profile;
  ProfileSucceed({required this.profile});
}

// ignore: must_be_immutable
class ProfileFailed extends ProfileState {
  String message;
  ProfileFailed({required this.message});
}

class updateProfileFailed extends ProfileState{
  String message;
  updateProfileFailed({required this.message});
}

class updateProfileSuccess extends ProfileState{
  
}

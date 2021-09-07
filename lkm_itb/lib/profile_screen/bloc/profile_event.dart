part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class loadProfile extends ProfileEvent {
  User user;
  loadProfile({required this.user});
}

class updateProfile extends ProfileEvent{
  ProfileData user;
  updateProfile({required this.user});
}

class uploadImage extends ProfileEvent{
  String userID;
  File imageFile;
  uploadImage({required this.imageFile, required this.userID});
}
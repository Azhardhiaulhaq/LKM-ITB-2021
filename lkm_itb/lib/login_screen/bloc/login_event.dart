part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SignInButtonPressed extends LoginEvent {
  String email, password;
  SignInButtonPressed({required this.email, required this.password});
}

// ignore: must_be_immutable
class CheckEmail extends LoginEvent{
  String email;
  CheckEmail({required this.email});
}

// ignore: must_be_immutable
class CheckPassword extends LoginEvent{
  String password;
  CheckPassword({required this.password});
}
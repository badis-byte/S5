import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => ['loading'];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String username;
  @override
  List<Object> get props => ['logged'];

  LoginSuccess(this.username);
}

class LoginError extends LoginState {
  final String message;
  @override
  List<Object> get props => ['error'];
  LoginError(this.message);
}

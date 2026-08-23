import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLodingState extends AuthState {}

class AuthResponseState extends AuthState {
  Either<String, String> responce;
  AuthResponseState({required this.responce});
}

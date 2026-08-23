abstract class AuthEvent {}

class AuthLoginRequestEvent extends AuthEvent {
  String username;
  String password;
  AuthLoginRequestEvent({required this.username, required this.password});
}

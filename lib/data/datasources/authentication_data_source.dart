abstract class AuthenticationDataSource {
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  );
}

abstract interface class AuthenticationDataSource {
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  );
  Future<String> login(String username, String password);
}

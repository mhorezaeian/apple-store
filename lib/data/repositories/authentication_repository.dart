abstract class AuthenticationRepository {
  void register(String username, String password, String passwordConfirm);
  void login(String username, String password);
}

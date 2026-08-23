import 'package:apple_store/data/repositories/authentication_repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:apple_store/bloc/authentication/auth_event.dart';
import 'package:apple_store/bloc/authentication/auth_state.dart';

final _repository = locator.get<AuthenticationRepository>();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginRequestEvent>((event, emit) async {
      emit(AuthLodingState());
      var responce = await _repository.login(event.username, event.password);
      emit(AuthResponseState(responce: responce));
    });
  }
}

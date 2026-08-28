import 'package:apple_store/features/auth/data/repositories/authentication_repository.dart';
import 'package:apple_store/core/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:apple_store/features/auth/presentation/bloc/auth_event.dart';
import 'package:apple_store/features/auth/presentation/bloc/auth_state.dart';

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

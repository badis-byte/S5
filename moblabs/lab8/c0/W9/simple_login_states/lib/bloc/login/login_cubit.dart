import 'package:bloc/bloc.dart';
import 'package:simple_login_states/bloc/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<bool> actionProcessLogin(String username, String password) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 5)); // Simulate delay

    try {
      if (username == '123')
        emit(LoginSuccess(username)); // Emit success state
      else
        emit(LoginError('Invalid username or password...'));
    } catch (e) {
      emit(LoginError("An error occurred...")); // Emit error state
    }
    return true; // even driven architecture, has no meaning here :(
  }
}

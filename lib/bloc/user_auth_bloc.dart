import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shack15_web_view_demo/networking/network_utils.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  AbstractApiRepository apiService = AbstractApiRepository.getInstance();

  UserAuthBloc() : super(UserAuthInitialState()) {
    on<UserLogInEvent>(
      (event, emit) async {
        String sessionToken = await apiService.getSessionToken();
        Map<String, dynamic> data = await apiService.getAuthenticationUser(
          sessionToken: sessionToken,
          mobileNumber: event.mobileNumber,
          userName: event.userName,
        );
        emit(
          UserAuthSuccessState(
            data: data,
            sessionToken: sessionToken,
            webUrl: event.webUrl,
          ),
        );
      },
    );
  }
}

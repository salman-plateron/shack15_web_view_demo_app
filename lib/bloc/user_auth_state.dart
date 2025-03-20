part of 'user_auth_bloc.dart';

abstract class UserAuthState {}

final class UserAuthInitialState extends UserAuthState {}

class UserAuthSuccessState extends UserAuthState {
  final Map<String, dynamic> data;
  final String sessionToken;
  final String webUrl;
  UserAuthSuccessState({
    required this.data,
    required this.sessionToken,
    required this.webUrl,
  });
}

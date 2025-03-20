part of 'user_auth_bloc.dart';

abstract class UserAuthEvent {}

class UserLogInEvent extends UserAuthEvent {
  String mobileNumber;
  String userName;
  String webUrl;
  UserLogInEvent(
      {required this.mobileNumber,
      required this.userName,
      required this.webUrl});
}

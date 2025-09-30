import 'package:assignment/model/user_model.dart';

abstract class UserState {}

class UserListInitialState extends UserState {}

class UserListLoadingState extends UserState {}

class UserListLoadedState extends UserState {
  UserListLoadedState({this.userList});

  final List<User>? userList;
}

class UserListErrorState extends UserState {
  UserListErrorState({this.msg});

  final String? msg;
}

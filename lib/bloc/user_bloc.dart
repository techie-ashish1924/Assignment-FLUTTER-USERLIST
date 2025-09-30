import 'dart:async';

import 'package:assignment/bloc/user_event.dart';
import 'package:assignment/bloc/user_state.dart';
import 'package:assignment/model/user_model.dart';
import 'package:assignment/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  List<User> _userList = [];

  UserBloc(this.userRepository) : super(UserListInitialState()) {
    on<FetchUserListEvent>(fetchUserListEvent);
    on<RefreshUserListEvent>(refreshUserList);
    on<RemoveUserListEvent>(removeUserList);
    on<UserSearchEvent>(userSearch);
  }

  //   on<FetchUserListEvent>(fetchUserListEvent);

  Future<void> fetchUserListEvent(
    FetchUserListEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserListLoadingState());
    try {
      final userList = await userRepository.fetchUser();
      _userList = userList;
      //   final userList2 = await userRepository.fetchUser();
      //   final userList3 = [...userList2, ...userList1];
      emit(UserListLoadedState(userList: userList));
    } catch (e) {
      emit(UserListErrorState(msg: e.toString()));
    }
  }

  Future<void> refreshUserList(
    RefreshUserListEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserListLoadingState());

    try {
      final userList = await userRepository.fetchUser();
      _userList = userList;
      emit(UserListLoadedState(userList: userList));
    } catch (e) {
      emit(UserListErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> removeUserList(
    RemoveUserListEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserListLoadingState());

    try {
      _userList = [];
      emit(UserListLoadedState(userList: []));
    } catch (e) {
      emit(UserListErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> userSearch(UserSearchEvent event, Emitter<UserState> emit) {
    emit(UserListLoadingState());

    try {
      final filteredList = _userList
          .where(
            (user) =>
                user.name!.toLowerCase().contains(event.user.toLowerCase()),
          )
          .toList();
      emit(UserListLoadedState(userList: filteredList));
    } catch (e) {
      emit(UserListErrorState(msg: e.toString()));
    }
  }
}

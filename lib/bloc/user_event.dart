abstract class UserEvent {}

class UserInitialEvent extends UserEvent {}

class FetchUserListEvent extends UserEvent {}

class RemoveUserListEvent extends UserEvent {}

class RefreshUserListEvent extends UserEvent {}

class UserSearchEvent extends UserEvent {
  UserSearchEvent({required this.user});

  final String user;
}

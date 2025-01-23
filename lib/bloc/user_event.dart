part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final String userName;
  final String userDesignation;
  final int userRollNumber;

  AddUserEvent(this.userName, this.userDesignation, this.userRollNumber);
}

class DeleteUserEvent extends UserEvent {
  final String userId;
  DeleteUserEvent(this.userId);
}

class UpdateUserEvent extends UserEvent {
  final String userId;
  final String userName;
  final String userDesignation;
  final int userRollNumber;

  UpdateUserEvent(
      this.userId, this.userName, this.userDesignation, this.userRollNumber);
}

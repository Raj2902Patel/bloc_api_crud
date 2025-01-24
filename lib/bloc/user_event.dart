part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final String userName;
  final String userDesignation;
  final int userRollNumber;
  final bool isChecked;
  final String createdDate;
  final String updatedAt;

  AddUserEvent(
    this.userName,
    this.userDesignation,
    this.userRollNumber,
    this.isChecked,
    this.createdDate,
    this.updatedAt,
  );
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
  final bool isChecked;
  final String updatedAt;

  UpdateUserEvent(this.userId, this.userName, this.userDesignation,
      this.userRollNumber, this.isChecked, this.updatedAt);
}

class CheckboxUserEvent extends UserEvent {}

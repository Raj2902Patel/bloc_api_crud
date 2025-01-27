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
  final String countryName;

  AddUserEvent(
    this.userName,
    this.userDesignation,
    this.userRollNumber,
    this.isChecked,
    this.createdDate,
    this.updatedAt,
    this.countryName,
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
  final String countryName;

  UpdateUserEvent(this.userId, this.userName, this.userDesignation,
      this.userRollNumber, this.isChecked, this.updatedAt, this.countryName);
}

class CountryEvent extends UserEvent {
  final String selectedCountry;
  CountryEvent(this.selectedCountry);
}

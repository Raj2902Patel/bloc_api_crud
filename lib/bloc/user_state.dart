part of 'user_bloc.dart';

@immutable
abstract class UserState {}

final class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final List<dynamic> data;
  UserSuccessState(this.data);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}

class CheckBoxState extends UserState {
  final bool isChecked;
  CheckBoxState(this.isChecked);
}

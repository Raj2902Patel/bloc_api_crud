import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final String apiURL =
      "https://6735d8b65995834c8a945415.mockapi.io/api/addData/users";

  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>(_onLoadData);
    on<AddUserEvent>(_onAddData);
    on<DeleteUserEvent>(_onDeleteData);
    on<UpdateUserEvent>(_onUpdateData);
  }

  Future<void> _onUpdateData(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await Dio().put("$apiURL/${event.userId}", data: {
        'userName': event.userName,
        'userDesignation': event.userDesignation,
        'userRollNumber': event.userRollNumber
      });
      add(LoadUserEvent());
    } catch (error) {
      emit(UserErrorState("Failed to Update Data"));
    }
  }

  Future<void> _onDeleteData(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await Dio().delete("$apiURL/${event.userId}");
      add(LoadUserEvent());
    } catch (error) {
      emit(UserErrorState("Failed To Delete Data"));
    }
  }

  Future<void> _onLoadData(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final response = await Dio().get(apiURL);
      emit(UserSuccessState(response.data));
    } catch (error) {
      emit(UserErrorState("Failed To Load Data"));
    }
  }

  Future<void> _onAddData(AddUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await Dio().post(apiURL, data: {
        'userName': event.userName,
        'userDesignation': event.userDesignation,
        'userRollNumber': event.userRollNumber
      });
      add(LoadUserEvent());
    } catch (error) {
      emit(UserErrorState("Failed To Add Data"));
    }
  }
}

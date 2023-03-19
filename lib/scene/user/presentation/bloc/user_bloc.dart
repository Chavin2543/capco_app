import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:capco_app/scene/user/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/models/failure.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(UserInitial()) {
    on<GetUsersEvent>((event, emit) => _onGetUsersRequested(event, emit));
  }

  _onGetUsersRequested(GetUsersEvent event, Emitter<UserState> emit) async {
    emit(UsersLoading());

    final result = await getUsersUseCase.execute();
    emit(result.fold((l) => UsersLoadedWithError(message: _getErrorMessage(l)),
        (r) => UsersLoadedWithSuccess(users: r)));
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'An unknown error has occured';
    }
  }
}

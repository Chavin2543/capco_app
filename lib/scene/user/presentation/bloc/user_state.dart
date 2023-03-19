part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UsersLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UsersLoadedWithSuccess extends UserState {
  final List<User> users;

  UsersLoadedWithSuccess({required this.users});
  @override
  List<Object?> get props => [users];
}

class UsersLoadedWithError extends UserState {
  final String message;

  UsersLoadedWithError({required this.message});
  @override
  List<Object?> get props => [message];
}
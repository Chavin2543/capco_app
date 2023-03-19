part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {}

class GetUsersEvent extends UserEvent {
  GetUsersEvent();

  @override
  List<Object?> get props => [];
}

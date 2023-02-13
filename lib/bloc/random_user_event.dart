part of 'random_user_bloc.dart';

@immutable
abstract class RandomUserEvent {}

class UpdateUser extends RandomUserEvent {
  final String? gender;
  UpdateUser({this.gender});
}

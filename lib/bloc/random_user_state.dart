part of 'random_user_bloc.dart';

@immutable
abstract class RandomUserState {}

class RandomUserInitial extends RandomUserState {}

class RandomUserSucces extends RandomUserState {
  final UserModel model;
  RandomUserSucces({required this.model});
}

class RandomUserError extends RandomUserState {}

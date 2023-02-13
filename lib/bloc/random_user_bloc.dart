import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:random_user_08_00/get_user_data_repo.dart';
import 'package:random_user_08_00/user_model.dart';

part 'random_user_event.dart';
part 'random_user_state.dart';

class RandomUserBloc extends Bloc<RandomUserEvent, RandomUserState> {
  RandomUserBloc({required this.repo}) : super(RandomUserInitial()) {
    on<UpdateUser>(
      (event, emit) async {
        try {
          final result = await repo.getUserData(gender: event.gender ?? '');
          emit(RandomUserSucces(model: result));
        } catch (e) {
          emit(RandomUserError());
        }
      },
    );
  }
  final GetUserDataRepo repo;
}

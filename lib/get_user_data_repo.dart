import 'package:dio/dio.dart';
import 'package:random_user_08_00/user_model.dart';

class GetUserDataRepo {
  final Dio dio;
  GetUserDataRepo({required this.dio});

  Future<UserModel> getUserData({required String gender}) async {
    final response = await dio.get(
      'https://randomuser.me/api/',
      queryParameters: {'gender': gender},
    );
    return UserModel.fromJson(response.data);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:mystudy/auth/data/model/user_model.dart';

class AuthService {
  final Dio http;

  AuthService({
    required this.http,
  });

  Future<bool> register(UserModel user) async {
    try {
      await http.post(
        '/register',
        data: user.toJson(),
      );

      return true;
    } on DioException {
      return false;
    }
  }

  Future<dynamic> login({
    required String? email,
    required String? password,
  }) async {
    try {
      Response response = await http.post(
        '/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      return response.data;
    } on DioException {
      return false;
    }
  }

  Future<UserModel> getCurrentUser() async {
    Response response = await http.get('/users/me');
    // print(response.data);
    return UserModel.fromJson(response.data);
  }

  Future<List<UserModel>> getAllUsers() async {
    final response = await http.get('/users');
    final List<dynamic> data = response.data;
    return data.map((user) => UserModel.fromJson(user)).toList();
  }
}

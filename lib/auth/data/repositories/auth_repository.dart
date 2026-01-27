// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mystudy/auth/data/model/user_model.dart';
import 'package:mystudy/auth/data/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository({
    required this.service,
  });

  Future<bool> register(UserModel user) async {
    await service.register(user);
    dynamic data =
        await service.login(email: user.email, password: user.password);
    print("resultat:$data");

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data['token'] != null) {
      await prefs.setString('token', data['token']);
      await prefs.setInt('userId', data['userId']);
    } else {
      //throw Exception("Erreur : Token d'accès manquant dans la réponse.");
      return false;
    }

    return true;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    dynamic data = await service.login(
      email: email,
      password: password,
    );

    // print("resultat:$data");

    if (data is bool) return false;

    if (data.containsKey("message")) return false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data['token'] != null) {
      await prefs.setString('token', data['token']);
      await prefs.setInt('userId', data['userId']);
      await prefs.setStringList('role', List<String>.from(data['role']));
    } else {
      //throw Exception("Erreur : Token d'accès manquant dans la réponse.");
      return false;
    }

    return true;
  }

  Future<UserModel> getCurrentUser() async {
    return await service.getCurrentUser();
  }

  Future<List<UserModel>> getAllUsers() async {
    return await service.getAllUsers();
  }
}

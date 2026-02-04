import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends QueuedInterceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    if (options.path.contains('/login') || options.path.contains('/register')) {
      handler.next(options);
      return;
    }
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['userId'];
    }
    handler.next(options);
  }
}

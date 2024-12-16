
import 'package:dio/dio.dart';
import 'package:shared_preferences.dart';

class Api {
  static final Api _instance = Api._internal();
  late final Dio _dio;

  factory Api() {
    return _instance;
  }

  Api._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.sentient.io',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
    ));
  }

  Future<void> _onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString('apikey');
    
    if (apiKey != null) {
      options.headers['x-api-key'] = apiKey;
    }
    
    return handler.next(options);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // Handle unauthorized access - you might want to navigate to login screen
    }
    return handler.next(err);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }
}

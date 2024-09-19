import 'dart:html' as html;
import 'package:cashier_web_/model/config.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio;
  String message = ''; 

  AuthService() : _dio = Dio(BaseOptions(baseUrl: Config.baseUrl));

  Future<Map<String, dynamic>> login(String email, String password) async {
    const url = '/auth/login';
    try {
      final response = await _postRequest(url, {
        'email': email,
        'password': password,
      });

      if (response != null && response['statusCode'] == 200) {
        final data = response['data'] ?? {};
        return {
          'userId': data['userId'] ?? '',
          'accessToken': data['accessToken'] ?? '',
          'refreshToken': data['refreshToken'] ?? '',
        };
      } else {
        return {'error': response['messageResponse'] ?? ''};
      }
    } catch (e) {
      print('Unexpected error: $e');
      return {'error': 'An unexpected error occurred. Please try again later.'};
    }
  }

  Future<Map<String, dynamic>> _postRequest(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        print('Failed request with status: ${response.statusCode}');
        return {'error': 'Failed to load data: ${response.statusCode}'};
      }
    } catch (e) {
      print('Error during request: $e');
      return {'error': 'There was a problem with the request: $e'};
    }
  }
}

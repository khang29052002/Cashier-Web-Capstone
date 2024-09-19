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
      print('Response data: ${response}');

      if (response['statusCode'] == 200) {
        final data = response['data'];
        if (data['accessToken'] != null && data['roleName'] == 'Admin') {
          message = 'Tài khoản Admin không được phép đăng nhập!';
          return {'error': message};
        }

        message = 'Đăng nhập thành công!'; 
        return {
          'userId': data['userId'] ?? 'defaultUserId',
          'accessToken': data['accessToken'] ?? 'defaultAccessToken',
          'refreshToken': data['refreshToken'] ?? 'defaultRefreshToken',
        };
      } else {
        message = response['messageResponse'] ?? 'Lỗi không xác định';  
        return {'error': message};
      }
    } on DioError catch (e) {
      message = e.response?.data['messageResponse'] ?? 'Lỗi không xác định'; 
      return {'error': message};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    const url = '/auth/forgot-password';
    try {
      final response = await _postRequest(url, {
        'email': email,
      });
      message = response['statusCode'] == 200 
          ? 'Kiểm tra email để đặt lại mật khẩu!' 
          : response['messageResponse'] ?? 'Lỗi không xác định';
      return response;
    } on DioError catch (e) {
      message = e.response?.data['messageResponse'] ?? 'Có lỗi xảy ra khi gửi yêu cầu đặt lại mật khẩu.';
      return {'error': message};
    }
  }

  Future<Map<String, dynamic>> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    const url = '/auth/change-password';
    try {
      final response = await _postRequest(url, {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
      if (response['statusCode'] == 200) {
        message = 'Đổi mật khẩu thành công!';
        return response['data'];
      } else {
        message = response['messageResponse'] ?? 'Lỗi không xác định';
        return {'error': message};
      }
    } on DioError catch (e) {
      message = e.response?.data['messageResponse'] ?? 'Lỗi không xác định';
      return {'error': message};
    }
  }

  Future<Map<String, dynamic>> _postRequest(
    String path, Map<String, dynamic> data) async {
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
      return response.data;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during request: $e'); // Added debug print
    throw Exception('There was a problem with the request: $e');
  }
}
}
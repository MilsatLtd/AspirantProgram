import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/api/data.dart';
import 'package:milsat_project_app/extras/env.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: '${Env.apiUrl}/api',
    headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${cred['access']}',
      'Content-Type': 'application/json',
      'X-CSRFToken':
          'f2EHSzIHjKcULae1oEqWCsr1wJgZUJH1RTKtPlxT0JLmPlXydW3ucNjhS2XnT2YO',
    },
  ));
});

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<void> resetPassword(data) async {
    try {
      String url = '${Env.apiUrl}/api/auth/password/change';

      final response = await dio.put(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        personalInfo['message'] = response.data['message'];
        if (kDebugMode) {
          print(response.data['message']);
        }
      } else if (response.statusCode == 400) {
        personalInfo['message'] = response.data['message'];
        if (kDebugMode) {
          print(response.data['message']);
        }
      } else {
        // Handle error response
        if (kDebugMode) {
          print(
            'reset password failed with status code: ${response.statusCode}',
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error resetting password: $e');
      }
    }
  }
}

final resetPasswordProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

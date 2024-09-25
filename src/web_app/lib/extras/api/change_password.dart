import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/api/data.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/env.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: '${Env.apiUrl}/api',
  ));
});

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<void> changePassword(data) async {
    try {
      String url = '${Env.apiUrl}/api/auth/password/change';
      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
      final response = await dio.put(url,
          data: data,
          options: Options(
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ));
      if (kDebugMode) {
        print(response.statusCode);
      }
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
        if (kDebugMode) {
          print(
            'reset password failed with status code: ${response.statusCode}',
          );
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        personalInfo['message'] =
            "${e.message} \n Old password is incorrect 🧐";
      } else {
        personalInfo['message'] = e.message;
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}

final changePasswordProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/env.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

final forgotPasswordProvider =
    Provider.autoDispose<ForgotPasswordService>((ref) {
  final dio = ref.watch(dioProvider);
  return ForgotPasswordService(dio);
});

class ForgotPasswordService {
  final Dio dio;

  ForgotPasswordService(this.dio);
  late String message;

  Future<String> forgotPassword(String email, String profileType) async {
    try {
      String url = '${Env.apiUrl}/api/auth/forgot_password';
      final response = await Dio().post(
        url,
        options: Options(headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        }),
        data: {
          'email': email,
          'profile_type': profileType,
        },
      );

      switch (response.statusCode) {
        case 200:
          message = response.data;
          return message;

        case 404:
          throw (response.data['message']);
        default:
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('${e.response}');
      } else if (e.error is SocketException) {
        throw ('${e.response}');
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw ('${e.response}');
      } else if (e.response?.statusCode == 404) {
        throw ('${e.response}');
      } else {
        throw ('${e.response}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return message;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/env.dart';
import 'package:milsat_project_app/extras/models/forgot_password_model.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

final forgotPasswordProvider =
    Provider.autoDispose<ForgotPasswordService>((ref) {
  final dio = ref.watch(dioProvider);
  return ForgotPasswordService(dio);
});

bool hasError = false;

class ForgotPasswordService {
  final Dio dio;

  ForgotPasswordService(this.dio);

  ForgotPasswordResponse message = ForgotPasswordResponse();

  Future<ForgotPasswordResponse> forgotPassword(
    String email,
    String profileType,
  ) async {
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
          ForgotPasswordResponse message =
              ForgotPasswordResponse.fromJson(response.data);
          print(message.message);
          print(message.profileType);
          return message;

        case 404:
          throw (response.data['message']);
        default:
      }
    } on DioError catch (e) {
      message = ForgotPasswordResponse.fromJson(e.response!.data);
      hasError = true;
      return message;
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return message;
  }

  Future<ForgotPasswordResponse> inputToken(
      int token, String newPassword, String confirmPassword) async {
    try {
      String url = '${Env.apiUrl}/api/auth/reset_password/';
      final response = await Dio().post(
        url,
        options: Options(headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        }),
        data: {
          'token': token,
          'password': newPassword,
          'confirm_password': confirmPassword,
        },
      );

      switch (response.statusCode) {
        case 200:
          ForgotPasswordResponse message =
              ForgotPasswordResponse.fromJson(response.data);

          return message;

        case 404:
          throw (response.data['message']);
        default:
      }
    } on DioError catch (e) {
      message = ForgotPasswordResponse.fromJson(e.response!.data);
      hasError = true;
      return message;
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return message;
  }
}

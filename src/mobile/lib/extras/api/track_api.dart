import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/env.dart';

import 'data.dart';

final dioApiProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.headers['accept'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer ${cred['access']}';
  dio.options.headers['X-CSRFToken'] =
      'f2EHSzIHjKcULae1oEqWCsr1wJgZUJH1RTKtPlxT0JLmPlXydW3ucNjhS2XnT2YO';
  return dio;
});

final trackApiProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioApiProvider);
  return ApiService(dio);
});

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Response> getTracks(String id) async {
    final url = '${Env.apiUrl}/api/tracks/cohort/$id';
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print(response.data);
      }
      cred['trackData'] = response.data;

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Request was made and server responded with a status code
        return e.response!;
      } else {
        // Request was made but no response received or request failed before it could complete
        throw Exception('Error making request: ${e.message}');
      }
    } catch (e) {
      // Catch any other errors
      throw Exception('Error making request: ${e.toString()}');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/env.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: '${Env.apiUrl}/api',
    ),
  );
});

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<void> submitReport(data) async {
    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      await dio.post(
        '/reports/create',
        data: data,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (kDebugMode) {
        print('Report submitted successfully');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Error status code: ${e.response?.statusCode}');
        }
        if (kDebugMode) {
          print('Error message: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Error message: ${e.message}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Unknown error occurred: $e');
      }
      rethrow;
    }
  }

  // Future<void> giveReportFeedback(){
  //   final url =
  // }
}

final apiReportProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

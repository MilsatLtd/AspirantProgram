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
    },
  ));
});

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<void> submitReport(data) async {
    try {
      await dio.post(
        '/reports/create',
        data: data,
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
}

final apiReportProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

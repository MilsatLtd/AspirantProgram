import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/api/data.dart';

import '../components/base_url.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: APIEndpoint.baseUrl,
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
      // ignore: use_rethrow_when_possible
      throw e;
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

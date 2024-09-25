import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/api/data.dart';
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
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
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
    } on DioException catch (e) {
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

  Future<Response> getSubmmittedReport_() async {
    const url = '${Env.apiUrl}/api/reports/';
    try {
      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      cred['reports'] = response.data;
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception('Error making request: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
  }

  Future<Response> getReportSubmmittedToMentor(String? mentorId) async {
    final url = '${Env.apiUrl}/api/reports/mentor/$mentorId';
    try {
      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      cred['mentorReports'] = response.data;
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception('Error making request: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
  }

  Future<void> giveReportFeedback(String reportId, data) async {
    try {
      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
      await dio.put(
        '/reports/feedback/$reportId',
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
        print('Report Feedback submitted successfully');
        message = ['Report Feedback submitted successfully'];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Error message: ${e.response?.data}');
          message = ['${e.response?.data['message']}'];
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

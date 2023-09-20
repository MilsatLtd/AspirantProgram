import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';

import '../components/base_url.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.headers['accept'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer ${cred['access']}';
  dio.options.headers['X-CSRFToken'] =
      'ZGguWASI6mZhHePPV4OGg29PkABNDWfjBxmgTmHUNlyJLpymKmreQn15GTibCfw6';
  return dio;
});

final apiServiceProvider = Provider.autoDispose<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

class ApiService {
  final Dio dio;

  ApiService(this.dio);
  MentorData mentorData = MentorData();
  AspirantModelClass aspirantData = AspirantModelClass();
  CourseModel courses = CourseModel();

  Future<AspirantModelClass> getUserData(String id) async {
    final url = '${APIEndpoint.baseUrl}api/students/$id';
    try {
      final response = await dio.get(url);

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            print('success');
          }
          AspirantModelClass aspirantData =
              AspirantModelClass.fromJson(response.data);
          return aspirantData;

        case 404:
          throw ('Invalid userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('failed');
      }
    }
    return aspirantData;
  }

  Future<MentorData> getMentorData(String id) async {
    final url = '${APIEndpoint.baseUrl}/api/mentors/$id';
    try {
      final response = await dio.get(url);

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            print('success');
          }
          MentorData mentorData = MentorData.fromJson(response.data);
          return mentorData;

        case 404:
          throw ('Invalid userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('failed');
      }
    }
    return mentorData;
  }

  Future<Response> getSubmmittedReport_() async {
    const url = '${APIEndpoint.baseUrl}/api/reports/';
    try {
      final response = await dio.get(url);
      if (kDebugMode) {
        print(response.data);
      }
      cred['reports'] = response.data;
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

  Future<CourseModel> getTrackCourses(String id, String trackId) async {
    final url = '${APIEndpoint.baseUrl}/api/students/courses/$id/$trackId';
    try {
      final response = await dio.get(url);

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            print('success');
          }
          CourseModel courses = CourseModel.fromJson(response.data);
          return courses;

        case 404:
          throw ('Invalid userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('failed');
      }
    }
    return courses;
  }
}

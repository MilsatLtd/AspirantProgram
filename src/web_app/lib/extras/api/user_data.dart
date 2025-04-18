import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/env.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
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

  Future<AspirantModelClass?> getUserData(String? id) async {
    try {
      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
      final response = await Dio().get(
        '${Env.apiUrl}/api/students/$id',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      switch (response.statusCode) {
        case 200:
          AspirantModelClass aspirantData =
              AspirantModelClass.fromJson(response.data);
          SharedPreferencesUtil.saveModel(
              SharedPrefKeys.userData, aspirantData);
          return aspirantData;

        case 404:
          throw ('Invalid userId');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('${e.response}');
      } else if (e.error is SocketException) {
        throw ('${e.response}');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ('${e.response}');
      } else if (e.response?.statusCode == 404) {
        throw ('${e.response}');
      } else {
        throw ('${e.response}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return aspirantData;
  }

  Future<MentorData> getMentorData(String? id) async {
    final url = '${Env.apiUrl}/api/mentors/$id';
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

      switch (response.statusCode) {
        case 200:
          MentorData mentorData = MentorData.fromJson(response.data);
          SharedPreferencesUtil.saveModel(
              SharedPrefKeys.mentorUserData, mentorData);
          return mentorData;

        case 404:
          throw ('Invalid userId');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('${e.response}');
      } else if (e.error is SocketException) {
        throw ('${e.response}');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ('${e.response}');
      } else if (e.response?.statusCode == 404) {
        throw ('${e.response}');
      } else {
        throw ('${e.response}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return mentorData;
  }

  Future<CourseModel> getTrackCourses(String id, String trackId) async {
    final url = '${Env.apiUrl}/api/students/courses/$id/$trackId';
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

      switch (response.statusCode) {
        case 200:
          CourseModel courses = CourseModel.fromJson(response.data);
          return courses;

        case 404:
          throw ('Invalid userId');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('${e.response}');
      } else if (e.error is SocketException) {
        throw ('${e.response}');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ('${e.response}');
      } else if (e.response?.statusCode == 404) {
        throw ('${e.response}');
      } else {
        throw ('${e.response}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return courses;
  }
}

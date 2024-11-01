import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/env.dart';
import 'package:milsat_project_app/extras/models/bio_model.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

final apiUploadProvider = Provider<APIService>((ref) {
  final dio = ref.watch(dioProvider);
  return APIService(dio);
});

class APIService {
  final Dio dio;

  APIService(this.dio);
  ProfilePictureResponse profileResponse = ProfilePictureResponse();
  BioResponseModel bioResponse = BioResponseModel();

  Future<void> submitTodo(String summary, String courseId, String studentId,
      String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        'summary': summary,
        'course': courseId,
        'student': studentId,
        'document': await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last),
      });

      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);

      final response = await dio.post(
        '${Env.apiUrl}/api/todos/submit',
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
            'X-CSRFToken':
                'EffsmhdnfzErfUTJKut1Rw5IRLw3NJBtg6lej32zWydTj5CgzM6zrRXYd4drM2Sg',
          },
        ),
      );

      // Check the response status
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
      } else {
        // Handle error response
        if (kDebugMode) {
          print(
            'Todo submission failed with status code: ${response.statusCode}',
          );
        }
      }
    } catch (e) {
      // Handle Dio or other network-related errors
      if (kDebugMode) {
        print('Error submitting todo: $e');
      }
    }
  }

  Future<ProfilePictureResponse?> uploadImage(String userId, File image) async {
    try {
      String url = '${Env.apiUrl}/api/users/update/picture/$userId';

      FormData formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);

      final response = await dio.put(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      switch (response.statusCode) {
        case 200:
          ProfilePictureResponse profileResponse =
              ProfilePictureResponse.fromJson(response.data);
          SharedPreferencesUtil.saveModel(
              SharedPrefKeys.profileResponse, profileResponse);
          return profileResponse;

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
    return profileResponse;
  }

  Future<BioResponseModel?> updateStatus(String userId, String bio) async {
    final url = '${Env.apiUrl}/api/users/update/$userId';
    try {
      String? token =
          await SharedPreferencesUtil.getString(SharedPrefKeys.accessToken);
      final response = await dio.put(
        url,
        data: {'bio': bio},
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      switch (response.statusCode) {
        case 200:
          BioResponseModel bioResponse =
              BioResponseModel.fromJson(response.data);
          return bioResponse;

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
    return bioResponse;
  }
}

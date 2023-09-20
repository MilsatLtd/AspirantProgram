import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/base_url.dart';
import '../components/files.dart';

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

      final response = await dio.post(
        '${APIEndpoint.baseUrl}/api/todos/submit',
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${cred['access']}',
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

  Future<void> uploadImage(String userId, File image) async {
    try {
      String url =
          '${APIEndpoint.baseUrl}/api/users/update/picture/$userId'; // Replace with your API endpoint

      FormData formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await dio.put(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${cred['access']}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      if (response.statusCode == 200) {
        personalInfo['personalUserInfo'] = response.data;
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
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      rethrow;
    }
  }

  Future<void> updateStatus(String userId, String bio) async {
    final url = '${APIEndpoint.baseUrl}/api/users/update/$userId';
    const csrfToken =
        'TU6MsR9FbN1siKAZqSsD8xRyKWANm0qsvLcypDYRSMAUmVjwfa5bISJO6fhbljHf';
    try {
      final response = await dio.put(
        url,
        data: {'bio': bio},
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${cred['access']}',
            'Content-Type': 'application/json',
            'X-CSRFToken': csrfToken,
          },
        ),
      );

      personalInfo['personalUserInfo'] = response.data;
      if (kDebugMode) {
        print(response.data);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      rethrow;
    }
  }
}

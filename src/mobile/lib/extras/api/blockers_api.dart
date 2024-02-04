import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/env.dart';
import 'package:milsat_project_app/extras/models/blocker_model.dart';

import '../components/files.dart';

final dioBlockerProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

final apiBlockerServiceProvider = Provider.autoDispose<APIService>((ref) {
  final dio = ref.watch(dioBlockerProvider);
  return APIService(dio);
});

class APIService {
  final Dio dio;

  APIService(this.dio);
  BlockerCommentModel blockerReply = BlockerCommentModel();

  Future<Response> postBlocker({
    required String trackId,
    required String userId,
    required String description,
    required String title,
    required int status,
  }) async {
    const url = '${Env.apiUrl}/api/blockers';

    final data = {
      'track': trackId,
      'user': userId,
      'description': description,
      'title': title,
      'status': status,
    };

    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );
      if (kDebugMode) {
        print(response.data);
      }
      return response;
    } catch (error) {
      throw Exception('Failed to post blocker: $error');
    }
  }

  Future<Response> resolveABlocker({
    required String trackId,
    required String userId,
    required String blockerId,
    required String description,
    required String title,
    required int status,
  }) async {
    final url = '${Env.apiUrl}/api/blockers/$blockerId';

    final data = {
      'track': trackId,
      'user': userId,
      'description': description,
      'title': title,
      'status': status,
    };

    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.put(
        url,
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        personalInfo['resolvedBlocker'] = response.data;
        if (kDebugMode) {
          print(response.data);
        }
      }

      return response;
    } catch (error) {
      throw Exception('Failed to post blocker: $error');
    }
  }

  Future<BlockerCommentModel> replyABlocker({
    required String message,
    required String userId,
    required String blocker,
  }) async {
    final url = '${Env.apiUrl}/api/blockers/comments/$blocker';

    final data = {
      'message': message,
      'user': userId,
      'blocker': blocker,
    };

    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );

      switch (response.statusCode) {
        case 201:
          BlockerCommentModel blockerReply =
              BlockerCommentModel.fromJson(response.data);
          return blockerReply;

        case 404:
          throw ('Invalid userId');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('${e.response}');
      } else if (e.error is SocketException) {
        throw ('${e.response}');
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw ('${e.response}');
      } else if (e.response?.statusCode == 404) {
        throw ('${e.response}');
      } else {
        throw ('${e.response}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return blockerReply;
  }

  Future<Response> getRaisedBlockers() async {
    const url = '${Env.apiUrl}/api/blockers';
    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print(response.data);
      }
      cred['blockers'] = response.data;
      if (kDebugMode) {
        print(response.data);
      }
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception('Error making request: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
  }

  Future<Response> getCommentsById(String blockerId) async {
    final url = '${Env.apiUrl}/api/blockers/comments/$blockerId';
    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        cred['blockerComments'] = response.data;
      }

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception('Error making request: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
  }
}

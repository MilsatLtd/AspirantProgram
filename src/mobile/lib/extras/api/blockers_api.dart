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

  List<BlockerCommentModel>? comments;
  BlockerCommentModel mentorComment = BlockerCommentModel();

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
      message = [
        'Blocker Submitted!',
        'You will get your feed soon!',
      ];
      return response.data;
    } on DioError catch (e) {
      message = [
        '${e.response!.data['message']}',
        '${e.response!.data['errors']['message']}'
      ];
      throw ('${e.response}');
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
      }
      message = ['Blocker Resolved Successfully'];
      return response;
    } on DioError catch (e) {
      message = ['${e.response?.data['message']}'];
      throw Exception('Failed to post blocker: $e');
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

      if (response.statusCode == 201) {
        BlockerCommentModel mentorComment =
            BlockerCommentModel.fromJson(response.data);
        return mentorComment;
      } else {}
    } on DioError {
      rethrow;
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
    return mentorComment;
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

  Future<List<BlockerCommentModel>> getCommentsById(String blockerId) async {
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
        List comments = response.data;
        return comments.map((e) => BlockerCommentModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw ('${e.response}');
    } catch (e) {
      throw Exception('Error making request: ${e.toString()}');
    }
  }

  Future<Response> deleteBlocker(String blockerId) async {
    final url = '${Env.apiUrl}/api/blockers/$blockerId';
    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.delete(
        url,
        options: Options(headers: headers),
      );
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

  Future<Response> deleteBlockerComment(String commentId) async {
    final url = '${Env.apiUrl}/api/blockers/comments/update/$commentId';
    try {
      String? token =
          await SecureStorageUtils.getString(SharedPrefKeys.accessToken);
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.delete(
        url,
        options: Options(headers: headers),
      );
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

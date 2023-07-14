import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/files.dart';

final blockerProvider = Provider<APIService>((ref) => APIService());

final Dio dio = Dio();

class APIService {
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${cred['access']}',
    'Content-Type': 'application/json',
    'X-CSRFToken':
        'S6U3cJRwFsmJYL1RsF4VXyhIWRdTmTRzuX0P9vGImrVb2WKohXHtxT9YiaUhlc8m',
  };
  Future<Response> postBlocker({
    required String trackId,
    required String userId,
    required String description,
    required String title,
    required int status,
  }) async {
    const url = 'https://map.up.railway.app/api/blockers';

    final data = {
      'track': trackId,
      'user': userId,
      'description': description,
      'title': title,
      'status': status,
    };

    try {
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
    final url = 'https://map.up.railway.app/api/blockers/$blockerId';

    final data = {
      'track': trackId,
      'user': userId,
      'description': description,
      'title': title,
      'status': status,
    };

    try {
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

  Future<Response> replyABlocker({
    required String message,
    required String userId,
    required String blocker,
  }) async {
    final url = 'https://map.up.railway.app/api/blockers/comments/$blocker';

    final data = {
      'message': message,
      'user': userId,
      'blocker': blocker,
    };

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );
      if (kDebugMode) {
        print(response.data);
      }
      personalInfo['blockerReply'] = response.data;
      return response;
    } catch (error) {
      throw Exception('Failed to post reply: $error');
    }
  }

  Future<Response> getRaisedBlockers() async {
    const url = 'https://map.up.railway.app/api/blockers';
    try {
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

  Future<Response> getCommentsById(String blockerId) async {
    final url = 'https://map.up.railway.app/api/blockers/comments/$blockerId';
    try {
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
}

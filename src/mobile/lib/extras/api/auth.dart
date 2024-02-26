import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/env.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

final signInProvider =
    StateNotifierProvider.autoDispose<SignInStateNotifier, SignInState>(
        (ref) => SignInStateNotifier());

class SignInState {
  final bool loading;
  final String error;
  final bool success;

  SignInState({
    required this.loading,
    required this.error,
    required this.success,
  });

  factory SignInState.initial() {
    return SignInState(
      loading: false,
      error: '',
      success: false,
    );
  }

  factory SignInState.loading() {
    return SignInState(
      loading: true,
      error: '',
      success: false,
    );
  }

  factory SignInState.error(String error) {
    return SignInState(
      loading: false,
      error: error,
      success: false,
    );
  }

  factory SignInState.success() {
    return SignInState(
      loading: false,
      error: '',
      success: true,
    );
  }

  bool get hasError => error.isNotEmpty;
}

class SignInStateNotifier extends StateNotifier<SignInState> {
  SignInStateNotifier() : super(SignInState.initial());

  Future<void> signIn(String email, String password) async {
    try {
      state = SignInState.loading();
      final response = await Dio().post(
        '${Env.apiUrl}/api/auth/login',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        var token = response.data['access'];
        var refreshToken = response.data['refresh'];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final decodedResponse = DecodedTokenResponse.fromJson(decodedToken);
        SecureStorageUtils.saveDataToStorage(SharedPrefKeys.tokenResponse,
            decodedResponse, (data) => data.toJsonString());
        SecureStorageUtils.saveString(SharedPrefKeys.accessToken, token);
        SecureStorageUtils.saveString(
            SharedPrefKeys.refreshToken, refreshToken);
        state = SignInState.success();
        if (state.success == true) {
          if (decodedResponse.role == 2) {
            AppNavigator.navigateTo(homeRoute);
          } else if (decodedResponse.role == 1) {
            AppNavigator.navigateTo(mentorSkeletonRoute);
          }
        }
      } else {
        state = SignInState.error('An error occurred. Please try again later.');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        state = SignInState.error('Incorrect email or password.');
      } else if (e.error is SocketException) {
        state = SignInState.error(
            'Network error. Please check your internet connection.');
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        state = SignInState.error('Request timeout. Please try again later.');
      } else {
        state = SignInState.error(
            'Error: ${e.response?.statusMessage}, Please try again later!');
      }
    } catch (e) {
      state = SignInState.error(e.toString());
    } finally {
      Timer(const Duration(seconds: 5), () {
        state = SignInState.initial();
        return;
      });
    }
  }
}

void signOut() {
  SignInState.initial();
  cred = {};
  AppNavigator.navigateToAndReplace(loginRoute);
}

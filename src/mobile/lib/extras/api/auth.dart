import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/env.dart';

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
      print('${Env.apiUrl}/api/auth/login');

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
        cred['access'] = token;
        cred['refresh'] = refreshToken;
        if (kDebugMode) {
          print(cred['access']);
        }
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        cred['Id'] = decodedToken.values.elementAt(4);
        if (kDebugMode) {
          print(cred['Id']);
        }
        cred['role'] = decodedToken.values.elementAt(7);
        cred['email'] = decodedToken.values.elementAt(6);
        cred['fullName'] = decodedToken.values.elementAt(5);

        state = SignInState.success();
        if (state.success == true) {
          if (decodedToken.values.elementAt(7) == 2) {
            AppNavigator.navigateTo(homeRoute);
          } else if (decodedToken.values.elementAt(7) == 1) {
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
      Timer(const Duration(seconds: 3), () {
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

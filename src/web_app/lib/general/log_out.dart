import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';

logOut(BuildContext context) {
  SharedPreferencesUtil.removeString(SharedPrefKeys.accessToken);
  SharedPreferencesUtil.removeString(SharedPrefKeys.tokenResponse);
  SharedPreferencesUtil.removeString(SharedPrefKeys.profileResponse);
  SharedPreferencesUtil.removeString(SharedPrefKeys.refreshToken);
  context.go(LoginScreen.route);
}

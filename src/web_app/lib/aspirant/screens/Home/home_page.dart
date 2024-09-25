import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';
import '../../../extras/components/files.dart';
import '../../../extras/models/aspirant_model.dart';

final aspirantDetails =
    FutureProvider.autoDispose<AspirantModelClass?>((ref) async {
  DecodedTokenResponse? response =
      await SharedPreferencesUtil.getModel<DecodedTokenResponse>(
          SharedPrefKeys.tokenResponse,
          (json) => DecodedTokenResponse.fromJson(json));
  return ref.read(apiServiceProvider).getUserData(response?.userId);
});

final currentTimeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home';
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ProfilePictureResponse? profilePictureResponse;
  void getUserProfile() async {
    profilePictureResponse =
        await SharedPreferencesUtil.getModel<ProfilePictureResponse>(
            SharedPrefKeys.profileResponse,
            (json) => ProfilePictureResponse.fromJson(json));
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context, ref, profilePictureResponse),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../extras/components/files.dart';
import '../../../extras/models/aspirant_model.dart';

final aspirantDetails =
    FutureProvider.autoDispose<AspirantModelClass?>((ref) async {
  DecodedTokenResponse? response =
      await SecureStorageUtils.getTokenResponseFromStorage(
          SharedPrefKeys.tokenResponse);
  return ref.read(apiServiceProvider).getUserData(response?.userId);
});

final currentTimeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context, ref),
    );
  }
}

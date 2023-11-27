import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../extras/components/files.dart';
import '../../../extras/models/aspirant_model.dart';

final aspirantDetails = FutureProvider.autoDispose<AspirantModelClass?>((ref) {
  return ref.read(apiServiceProvider).getUserData(cred['Id']);
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

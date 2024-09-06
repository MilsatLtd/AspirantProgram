import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'extras/components/files.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppTheme.kPurpleColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

late double screenWidth;
late double screenHeight;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      title: 'MILSAT ASPIRANT',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      navigatorKey: AppNavigator.navKey,
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}

// navigation_service.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NavigationService {
  static const String _routeKey = SharedPrefKeys.lastRoute;
  static const String _extraKey = SharedPrefKeys.lastExtra;

  static Future<void> saveCurrentRoute({
    required String path,
    Object? extra,
  }) async {
    if (!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    // Ensure the path starts with '/'
    final normalizedPath = path.startsWith('/') ? path : '/$path';

    await prefs.setString(_routeKey, normalizedPath);

    // Save extra data if present
    if (extra != null && (extra as Map).isNotEmpty) {
      // Convert extra to a JSON string if possible
      if (extra is List || extra is num || extra is String || extra is bool) {
        await prefs.setString(_extraKey, jsonEncode(extra));
      } else {
        // For complex objects, save their toString() representation
        await prefs.setString(_extraKey, extra.toString());
      }
    }
  }

  static Future<Map<String, dynamic>> getLastRouteInfo() async {
    if (!kIsWeb) return {};

    final prefs = await SharedPreferences.getInstance();
    final savedRoute = prefs.getString(_routeKey);
    final savedExtra = prefs.getString(_extraKey);

    dynamic extraData;
    if (savedExtra != null) {
      extraData = jsonDecode(savedExtra);
    }

    return {
      'route': savedRoute,
      'extra': extraData,
    };
  }

  static Future<void> clearSavedRoute() async {
    if (!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_routeKey);
    await prefs.remove(_extraKey);
  }
}

class CustomRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _saveRoute(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) _saveRoute(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) _saveRoute(previousRoute);
  }

  void _saveRoute(Route<dynamic> route) {
    if (route.settings.name != null) {
      NavigationService.saveCurrentRoute(
        path: route.settings.name!,
        extra: route.settings.arguments,
      );
    }
  }
}

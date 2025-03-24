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

    try {
      final prefs = await SharedPreferences.getInstance();
      // Ensure the path starts with '/'
      final normalizedPath = path.startsWith('/') ? path : '/$path';
      await prefs.setString(_routeKey, normalizedPath);

      // Handle extra data
      if (extra != null) {
        String? jsonString;

        try {
          if (extra is Map ||
              extra is List ||
              extra is num ||
              extra is String ||
              extra is bool) {
            jsonString = jsonEncode(extra);
          } else {
            // For complex objects that can't be directly encoded
            final map = {'data': extra.toString()};
            jsonString = jsonEncode(map);
          }

          await prefs.setString(_extraKey, jsonString);
        } catch (e) {
          debugPrint('Error encoding extra data: $e');
        }
      } else {
        // Clear extra data if none provided
        await prefs.remove(_extraKey);
      }
    } catch (e) {
      debugPrint('Error saving route: $e');
    }
  }

  static Future<Map<String, dynamic>> getLastRouteInfo() async {
    if (!kIsWeb) return {};

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedRoute = prefs.getString(_routeKey);
      final savedExtra = prefs.getString(_extraKey);

      dynamic extraData;
      if (savedExtra != null && savedExtra.isNotEmpty) {
        try {
          extraData = jsonDecode(savedExtra);

          // If the extra data was saved as a string representation
          if (extraData is Map && extraData.containsKey('data')) {
            extraData = extraData['data'];
          }
        } catch (e) {
          debugPrint('Error decoding extra data: $e');
          extraData = null;
        }
      }

      return {
        'route': savedRoute,
        'extra': extraData,
      };
    } catch (e) {
      debugPrint('Error getting route info: $e');
      return {};
    }
  }

  static Future<void> clearSavedRoute() async {
    if (!kIsWeb) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_routeKey);
      await prefs.remove(_extraKey);
    } catch (e) {
      debugPrint('Error clearing saved route: $e');
    }
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
      // Ensure arguments are serializable before saving
      final arguments = route.settings.arguments;
      if (arguments != null) {
        try {
          // Test if arguments can be JSON encoded
          jsonEncode(arguments);
        } catch (e) {
          debugPrint('Route arguments are not JSON serializable: $e');
          // Save route without arguments
          NavigationService.saveCurrentRoute(path: route.settings.name!);
          return;
        }
      }

      NavigationService.saveCurrentRoute(
        path: route.settings.name!,
        extra: arguments,
      );
    }
  }
}

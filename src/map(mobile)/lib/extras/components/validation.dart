import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  static void offKeyboard() async {
    await SystemChannels.textInput.invokeMethod<dynamic>('TextInput.hide');
  }

  static String? isValid(
    String value,
    String type,
  ) {
    value = value.trim();
    if (value.trim().isEmpty) {
      return "$type is required";
    } else if (value.trim().length < 10) {
      return "$type is too short";
    }
    return null;
  }

  static String? isValidPassword(String value) {
    value = value.trim();
    if (value.trim().isEmpty) {
      return "Password is required";
    } else if (value.trim().length <= 5) {
      return "Password is too week";
    } else if (!value.trim().contains(RegExp(r'[0-9]'))) {
      return "Password must contain a number";
    }
    return null;
  }

  static String? isValidName(String? value, String type, int length) {
    if (value!.isEmpty) {
      return '$type cannot be Empty';
    } else if (value.length < length) {
      return '$type is too short';
    } else if (value.length > 50) {
      return '$type max length is 50';
    }
    return null;
  }

  static String? validateEmail(String value) {
    value = value.trim();
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  static String todaysDate() {
    return DateFormat('MMMM dd').format(DateTime.now());
  }

  static void unfocusKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      return;
    }
    currentFocus.unfocus();
  }
}

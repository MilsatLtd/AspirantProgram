abstract class Env {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: '',
  );
}

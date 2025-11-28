import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralise les variables d'environnement liées à l'API.
/// Assure-toi d'appeler `await dotenv.load()` dans `main()` avant
/// d'accéder à ces valeurs.
class Api {
  Api._();

  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://api.example.com';

  static String get apiToken => dotenv.env['API_TOKEN'] ?? '';

  static String get anotherVar => dotenv.env['ANOTHER_VAR'] ?? '';
}

// Pour compatibilité rapide, expose aussi des alias top-level
String get BASE_URL => Api.baseUrl;
String get API_TOKEN => Api.apiToken;

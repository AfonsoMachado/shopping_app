import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final _baseUrl = "${dotenv.env['FIREBASE_URL']}";
  static final firebaseApiKey = "${dotenv.env['FIREBASE_API_KEY']}";

  static String get productBaseUrl {
    return "$_baseUrl/products";
  }

  static String get orderBaseUrl {
    return "$_baseUrl/orders";
  }

  static String get userFavorites {
    return "$_baseUrl/userFavorites";
  }
}

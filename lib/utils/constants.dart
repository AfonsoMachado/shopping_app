import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  final baseUrl = "${dotenv.env['FIREBASE_URL']}";

  static String get productBaseUrl {
    return "${dotenv.env['FIREBASE_URL']}/products";
  }

  static String get orderBaseUrl {
    return "${dotenv.env['FIREBASE_URL']}/orders";
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPref {
  final nameKey = "name";
  final imageKey = "phone";

  final nameStorage = const FlutterSecureStorage();
  final imageStorage = const FlutterSecureStorage();
}

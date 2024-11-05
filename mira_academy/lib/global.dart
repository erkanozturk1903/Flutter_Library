import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mira_academy/common/services/storage.dart';
import 'package:mira_academy/firebase_options.dart';

class Global {
  static late StorageService storageService;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    storageService = await StorageService().init();
  }
}

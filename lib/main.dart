import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseall/view/firebase_auth/google_sign_in_screen.dart';
import 'package:firebaseall/view/firebase_auth/mobile_sign_in_screen.dart';
import 'package:firebaseall/view/firebase_auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MobileScreen(),
    );
  }
}

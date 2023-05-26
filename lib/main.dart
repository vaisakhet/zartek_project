import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/food_controller.dart';
import 'package:zartek_project/Controllers/login_controller.dart';
import 'package:zartek_project/Views/authentication_screen.dart';
import 'Services/https_error.dart';
import 'Services/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefResponse.initialize();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final loginControoler = Get.put(LoginController());
  final foodController = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthenticationScreen(),
    );
  }
}

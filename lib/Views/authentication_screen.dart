import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/login_controller.dart';
import 'package:zartek_project/Views/phone_auth_screen.dart';
import '../Helpers/app_config.dart';

// ignore: must_be_immutable
class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          body: Column(children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset("Assets/images/firebase1.png"),
            SizedBox(height: App(context).appHeight(15)),
            GestureDetector(
              onTap: () async {
                await controller.googleSignIn(context);
              },
              child: Container(
                height: App(context).appHeight(8),
                width: App(context).appWidth(70),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 25,
                      backgroundImage: AssetImage("Assets/images/google.png"),
                    ),
                    Text(
                      "Google",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox()
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => PhoneAuthentication()));
              },
              child: Container(
                height: App(context).appHeight(8),
                width: App(context).appWidth(70),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    Text(
                      "Phone",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox()
                  ],
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/login_controller.dart';
import 'package:zartek_project/Views/authentication_Screen.dart';
import '../Services/shared_preference.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  final _prefns = SharedPrefResponse.instance;
  LoginController loginController = Get.put(LoginController());

  DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            child: Column(children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 179, 237, 181),
                      Color.fromARGB(255, 40, 122, 44),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: NetworkImage(
                            'https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg'),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 270,
                        child: Center(
                          child: Text(
                            '${_prefns.usersName} ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 270,
                        child: Center(
                          child: Text(
                            'ID : ${_prefns.usersID}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: () async {
                    await controller.logouts();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AuthenticationScreen()),
                        (route) => false);
                  },
                  child: const Row(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 20),
                      Text('Log out',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

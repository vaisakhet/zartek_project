import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/cart_controller.dart';
import 'package:zartek_project/Views/home_Screen.dart';

class PlaceOrderButton extends StatelessWidget {
  PlaceOrderButton({super.key});

  final CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[900],
            ),
            child: const Text(
              'Place Order',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              controller.clearCart();
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          'Success',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Your order succefully placed !',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const HomeScreen()),
                                  (route) => false);
                            },
                            child: Container(
                              height: 40,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Center(
                                child: Text(
                                  'done',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          )
                        ],
                      ));
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/cart_controller.dart';

class CountButtons extends StatelessWidget {
  final int quantity;
  final String productId;

  CountButtons(this.quantity, this.productId, {super.key});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return SizedBox(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.decrementQuantity(productId);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
              ),
              Container(
                height: 35,
                width: 35,
                color: Colors.green[800],
                alignment: Alignment.center,
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cartController.incrementQuantity(productId);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

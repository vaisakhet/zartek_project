import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/cart_controller.dart';
import '../Widgets/cartitem_list.dart';
import '../Widgets/place_order_btn.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Order Summury",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            bottomNavigationBar: PlaceOrderButton(),
            body: controller.items.length == 0
                ? const Center(child: Text('No items in cart!'))
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.all(8),
                                height: 60,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: Colors.green[900]),
                                child: Text(
                                  "${controller.itemCount} Dishes - ${controller.productsCount} Items",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    final item =
                                        controller.items.values.toList()[index];
                                    return CartItemList(
                                      calories: item.calories,
                                      price: item.price,
                                      index: index,
                                      productId: item.productId,
                                      quantity: item.quantity,
                                      title: item.title,
                                    );
                                  },
                                  separatorBuilder: (c, i) {
                                    return const Divider(
                                      thickness: 1,
                                    );
                                  },
                                  itemCount: controller.items.length),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total Amount',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'INR ${controller.totalAmount}',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/cart_controller.dart';
import 'package:zartek_project/Widgets/veg_or_nonveg.dart';
import '../Views/cart_screen.dart';

class FoodItemList extends StatelessWidget {
  FoodItemList(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.calories,
      required this.price,
      required this.index,
      required this.description,
      required this.customisation,
      required this.dishId,
      required this.dishType});
  final String title;
  final String imageUrl;
  final double calories;
  final double price;
  final int index;
  final String description;
  final bool customisation;
  final String dishId;
  final int dishType;

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GreenCircleContainer(
                  dishType == 2 ? Colors.green : Colors.red[300]!),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 18, fontFamily: 'Roboto'),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('INR $price'),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Text('$calories Calories'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                description,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.addItem(
                                      productId: dishId,
                                      title: title,
                                      unit: '1',
                                      price: price,
                                      calories: calories);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => CartScreen()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                      child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (!customisation)
                                const Text(
                                  'Customisations Available',
                                  style: TextStyle(color: Colors.red),
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: FadeInImage(
                            image: NetworkImage(imageUrl),
                            placeholder: const AssetImage(
                                "Assets/images/foodPlaceHolderImage.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

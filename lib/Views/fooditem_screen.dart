import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/food_controller.dart';
import 'package:zartek_project/Widgets/fooditem_list.dart';

class FoodItems extends StatefulWidget {
  final int index;

  const FoodItems(this.index);

  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  final FoodController _foodController = Get.put(FoodController());
  @override
  void initState() {
    var selectedCat = _foodController.menuCategory[widget.index];
    _foodController.filterFood(selectedCat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 50),
        itemBuilder: (ctx, index) {
          final foods = _foodController.categoryDishList[index];

          final bool custom = foods.addonCat == null || foods.addonCat!.isEmpty;
          return FoodItemList(
            title: foods.dishName,
            imageUrl: foods.dishImage,
            calories: foods.dishCalories,
            price: foods.dishPrice,
            index: index,
            description: foods.dishDescription,
            customisation: custom,
            dishId: foods.dishId,
            dishType: foods.dishType,
          );
        },
        separatorBuilder: (ctx, i) {
          return const Divider(
            thickness: 1.0,
          );
        },
        itemCount: _foodController.categoryDishList.length);
  }
}

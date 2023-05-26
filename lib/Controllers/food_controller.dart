import 'package:get/get.dart';
import 'package:zartek_project/Model/restaurent_model.dart';
import '../Services/aip_services.dart';

class FoodController extends GetxController {
  List<String> menuCategory = [];
  List<CategoryDish> categoryDishList = [];
  Restaurant? _foodItems;
  @override
  void onInit() {
    getFoodItems();

    super.onInit();
  }

  Future<void> getFoodItems() async {
    try {
      _foodItems = await ApiService().fetchData();
      menuCategory.clear();
      if (_foodItems != null) {
        for (var item in _foodItems!.tableMenuList) {
          menuCategory.add(item.menuCategory);
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  List<CategoryDish> filterFood(String? query) {
    categoryDishList.clear();
    if (_foodItems != null && query != null) {
      for (var item in _foodItems!.tableMenuList) {
        if (item.menuCategory == query) {
          for (var dish in item.categoryDishes) {
            categoryDishList.add(dish);
          }
        }
      }
    }

    print(categoryDishList);
    return categoryDishList;
  }
}

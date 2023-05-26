import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartek_project/Controllers/cart_controller.dart';
import 'package:zartek_project/Controllers/food_controller.dart';
import 'package:zartek_project/Views/cart_screen.dart';
import '../Widgets/drawer_widget.dart';
import 'fooditem_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FoodController _foodProvider = Get.put(FoodController());
  final CartController cartController = Get.put(CartController());
  String? selectedCat;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    _foodProvider.getFoodItems().then((value) {
      selectedCat = _foodProvider.menuCategory[0];
      _foodProvider.filterFood(selectedCat);
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(
      builder: (controller) {
        return DefaultTabController(
          length: controller.menuCategory.length,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => CartScreen()));
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            size: 30,
                            color: Colors.grey,
                          )),
                      Positioned(
                        left: 28,
                        top: 10,
                        child: GetBuilder<CartController>(
                          builder: (cltr) {
                            return Container(
                              height: 20,
                              width: 18,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  cltr.itemCount.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
              bottom: TabBar(
                  onTap: (val) {
                    selectedCat = _foodProvider.menuCategory[val];
                    print(selectedCat);
                    _foodProvider.filterFood(selectedCat);
                    setState(() {});
                  },
                  indicatorColor: Colors.pink[300],
                  labelColor: Colors.pink[300],
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  indicatorWeight: 2.5,
                  tabs: controller.menuCategory
                      .map((e) => Tab(
                            text: e,
                          ))
                      .toList()),
            ),
            drawer: DrawerWidget(),
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : TabBarView(
                    children: List.generate(controller.menuCategory.length,
                        (index) => FoodItems(index))),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/cartitem_model.dart';

class CartController extends GetxController {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  /// Item Count
  int get itemCount {
    // ignore: unnecessary_null_comparison
    if (_items == null) {
      return 0;
    }

    return _items.length;
  }

  /// product Count

  int get productsCount {
    var length = 0;
    // ignore: unnecessary_null_comparison
    if (_items == null) {
      return length;
    }
    _items.forEach((key, value) {
      length += value.quantity * 1;
    });

    return length;
  }

  /// Total Amount

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /// Add item in to cart

  void addItem(
      {String? title,
      String? unit,
      double? price,
      double? calories,
      String? productId}) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId!,
        (existingItem) => CartItem(
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
            calories: existingItem.calories,
            productId: existingItem.productId,
            unit: existingItem.unit),
      );
    } else {
      _items.putIfAbsent(
        productId!,
        () => CartItem(
            title: title!,
            quantity: 1,
            price: price!,
            unit: unit!,
            calories: calories!,
            productId: productId),
      );
    }
    Get.snackbar(
      "$title Add to cart",
      "$price",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    update();
  }

  /// remove item in to cart

  void removeItem(int productId) {
    _items.remove(productId);
    // update();
  }

  void incrementQuantity(String productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
          calories: existingItem.calories,
          productId: existingItem.productId,
          unit: existingItem.unit),
    );
    Get.snackbar(
      "Add Item",
      "Success",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    update();
  }

  /// Degrement Quantity

  void decrementQuantity(String productId) {
    CartItem item =
        _items.values.firstWhere((element) => element.productId == productId);

    if (item.quantity <= 1) {
      _items.removeWhere((key, value) {
        return value.productId == productId;
      });
    } else {
      _items.update(
        productId,
        (existingItem) {
          return CartItem(
              title: existingItem.title,
              quantity: existingItem.quantity - 1,
              price: existingItem.price,
              calories: existingItem.calories,
              productId: existingItem.productId,
              unit: existingItem.unit);
        },
      );
    }
    Get.snackbar(
      "Remove Item ",
      "Success",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    update();
  }

  /// Clear items in cart

  void clearCart() {
    _items = {};
    update();
  }
}

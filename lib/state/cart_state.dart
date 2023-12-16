import 'dart:convert';

import 'package:flutter_eatit_new/model/cart_model.dart';
import 'package:flutter_eatit_new/model/food_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../strings/cart_string.dart';
import '../utils/const.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  getCart(String restaurantId) =>
      cart.where((item) => item.restaurantId == restaurantId);

  addToCart(FoodModel foodModel, String restaurantId,
      {int quantity = 1}) async {
    try {
      var cartItem = CartModel(
        id: foodModel.id,
        name: foodModel.name,
        description: foodModel.description,
        image: foodModel.image,
        price: foodModel.price,
        addon: foodModel.addon,
        size: foodModel.size,
        quantity: quantity,
        restaurantId: restaurantId,
      );
      if (isExists(cartItem, restaurantId)) {
        var foodNeedToUpdate =
            cart.firstWhere((element) => element.id == cartItem.id);
        foodNeedToUpdate.quantity += quantity;
      } else {
        cart.add(cartItem);
      }
      var jsonDBEncode = jsonEncode(cart);
      await box.write(MY_CART_KEY, jsonDBEncode);
      cart.refresh();
      Get.snackbar(successTitle, successMessage);
    } catch (e) {
      Get.snackbar(errorTitle, e.toString());
    }
  }

  bool isExists(CartModel cartItem, String restaurantId) =>
      cart.any((e) => e.id == cartItem.id && e.restaurantId == restaurantId);

  sumCart(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.price * e.quantity)
          .reduce((value, element) => value + element);

  getQuantity(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId).map((e) => e.quantity).reduce((value, element) => value + element);

  getShippingFee(String restaurantId) => sumCart(restaurantId) * 0.1;

  getSubTotal(String restaurantId) => sumCart(restaurantId) + getShippingFee(restaurantId);

  clearCart(String restaurantId) {
    getCart(restaurantId).clear();
    saveDatabase();
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));
}

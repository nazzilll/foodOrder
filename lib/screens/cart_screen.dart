import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/const/const.dart';
import 'package:flutter_eatit_new/state/main_state.dart';
import 'package:flutter_eatit_new/utils/utils.dart';
import 'package:flutter_eatit_new/view_model/cart_vm/cart_view_model.dart';
import 'package:flutter_eatit_new/view_model/cart_vm/cart_view_model_imp.dart';
import 'package:flutter_eatit_new/widgets/cart/cart_image_widget.dart';
import 'package:flutter_eatit_new/widgets/cart/cart_info_widget.dart';
import 'package:flutter_eatit_new/widgets/cart/cart_total_widget.dart';
import 'package:flutter_eatit_new/widgets/food_detail/food_detail_image_widget.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state/cart_state.dart';
import '../strings/cart_string.dart';

class CartDetailScreen extends StatelessWidget {
  final box = GetStorage();
  final CartStateController controller = Get.find();
  final MainStateController mainStateController = Get.find();
  final CartViewModelImp cartViewModel = new CartViewModelImp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cart',
        style: GoogleFonts
            .jetBrainsMono(
        color: Colors.black,
        fontSize: 25,)),
        actions: [
          controller.getQuantity(mainStateController
                      .selectedRestaurant.value.restaurantId) >
                  0
              ? IconButton(
                  onPressed: () => Get.defaultDialog(
                      title: clearCartConfirmTitleText,
                      middleText: clearCartConfirmContentText,
                      textCancel: cancelText,
                      textConfirm: confirmText,
                      confirmTextColor: Colors.yellow,
                      onConfirm: () => cartViewModel.clearCart(controller)),
                  icon: Icon(Icons.clear))
              : Container()
        ],
      ),
      body: controller.getQuantity(
                  mainStateController.selectedRestaurant.value.restaurantId) >
              0
          ? Obx(() => Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.cart.length,
                          itemBuilder: (context, index) => Slidable(
                                child: Card(
                                  elevation: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: CartImageWidget(
                                              cartModel: controller.cart[index],
                                              controller: controller),
                                        ),
                                        Expanded(
                                            flex: 6,
                                            child: CartInfo(
                                                cartModel:
                                                    controller.cart[index])),
                                        Center(
                                          child: ElegantNumberButton(
                                            initialValue:
                                                controller.cart[index].quantity,
                                            minValue: 1,
                                            maxValue: 100,
                                            color: Colors.yellow,
                                            onChanged: (value) {
                                              cartViewModel.updateCart(
                                                  controller,
                                                  index,
                                                  value.toInt());
                                            },
                                            decimalPlaces: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                startActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        Get.defaultDialog(
                                            title: deleteCartConfirmTitleText,
                                            middleText:
                                                deleteCartConfirmContentText,
                                            textCancel: cancelText,
                                            textConfirm: confirmText,
                                            confirmTextColor: Colors.yellow,
                                            onConfirm: () => cartViewModel
                                                .deleteCart(controller, index));
                                      },
                                      icon: Icons.delete,
                                      label: deleteText,
                                      backgroundColor: Colors.red,
                                    ),
                                  ],
                                ),
                              ))),
                  TotalWidget(
                    controller: controller,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(COLOR_MENU_BG)),
                      ),
                      onPressed: () {
                        // Step 2: Show Confirmation Dialog
                        Get.defaultDialog(
                          title: 'Checkout Confirmation',
                          middleText: 'Are you sure you want to checkout?',
                          textCancel: 'Cancel',
                          textConfirm: 'Confirm',
                          confirmTextColor: Colors.yellow,
                          onConfirm: () {
                            // Step 3: Handle Checkout Success
                            Get.back(); // Close the confirmation dialog
                            Get.snackbar(
                              'Checkout Success',
                              'Your order has been successfully checked out!',
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(seconds: 2),

                            );

                            // Step 4: Clear Cart
                            cartViewModel.clearCart(controller);
                          },
                        );
                      },
                      child: Text('Checkout',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                    ),
                  )
                ],
              ))
          : Center(
              child: Text(cartEmptyText),
            ),
    );
  }
}

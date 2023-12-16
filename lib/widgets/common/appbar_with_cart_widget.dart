import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/screens/cart_screen.dart';
import 'package:flutter_eatit_new/state/main_state.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state/cart_state.dart';

class AppBarWithCartButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final CartStateController cartStateController = Get.find();
  final MainStateController mainStateController = Get.find();

  AppBarWithCartButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '$title',
        style: GoogleFonts.jetBrainsMono(color: Colors.black),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        Obx(() => badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 1),
              showBadge: true,
              badgeContent: Text(
                '${cartStateController.getQuantity(mainStateController.selectedRestaurant.value.restaurantId)}',
                style: GoogleFonts.jetBrainsMono(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () => Get.to(() => CartDetailScreen()),
                icon: Icon(Icons.shopping_bag),
              ),
            )),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

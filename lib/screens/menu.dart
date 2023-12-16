import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/const/const.dart';
import 'package:flutter_eatit_new/view_model/menu_vm/menu_view_model_imp.dart';
import 'package:flutter_eatit_new/widgets/menu/menu_widget_callback.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../strings/restaurant_home_strings.dart';
import '../widgets/menu/menu_widget.dart';
import '../widgets/menu/home_menu_widget.dart';

class MenuScreen extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;
  final MenuViewModelImp viewModel = MenuViewModelImp();
  final FirebaseApp app;
  final User user;

  MenuScreen(this.zoomDrawerController, this.app, this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(COLOR_MENU_BG),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: Color(COLOR_ICON_DRAWER),
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            HomeMenuWidget(zoomDrawerController: zoomDrawerController),
            Divider(
              thickness: 1,
            ),
            MenuWidget(
              icon: Icons.restaurant_rounded,
              menuName: restaurantListText,
              callback: viewModel.backToRestaurantList,
            ),
            Divider(
              thickness: 1,
            ),
            MenuWidget(
              icon: Icons.list,
              menuName: categoriesText,
              callback: viewModel.navigateCategories,
            ),
            Divider(
              thickness: 1,
            ),
            MenuWidget(
              icon: Icons.person,
              menuName: profileText,
              callback: () => viewModel.navigateProfile(app: app, user: user),
            ),
            Spacer(),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
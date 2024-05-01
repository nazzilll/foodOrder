import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/model/change_theme_button_widget.dart';
import 'package:flutter_eatit_new/screens/category.dart';
import 'package:flutter_eatit_new/screens/profile.dart';
import 'package:flutter_eatit_new/screens/restaurant_home.dart';
import 'package:flutter_eatit_new/strings/restaurant_home_strings.dart';
import 'package:flutter_eatit_new/utils/const.dart';
import 'package:flutter_eatit_new/view_model/menu_vm/menu_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../strings/main_strings.dart';

class MenuViewModelImp implements MenuViewModel {
  late final FirebaseApp app;
  late final User user;

  @override
  void navigateCategories() {
    Get.to(() => CategoryScreen());
  }

  @override
  void backToRestaurantList() {
    Get.back(closeOverlays: true, canPop: false);
  }

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }




  @override
  void navigationHome(BuildContext context) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var box = GetStorage();
    box.write(KEY_TOKEN, token);
  }

  @override
  void navigateProfile({FirebaseApp? app, User? user}) {
    Get.to(() => Profile(app: app!, user: user!));
  }
  @override
  void changeTheme({FirebaseApp? app, User? user}) {

    ChangeThemeButtonWidget();

  }
}

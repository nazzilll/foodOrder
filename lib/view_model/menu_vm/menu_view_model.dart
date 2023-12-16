import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

abstract class MenuViewModel{
  void navigateCategories();
  void backToRestaurantList();
  bool checkLoginState(BuildContext context);
  void navigationHome(BuildContext context);
  void navigateProfile({FirebaseApp? app, User? user});
}
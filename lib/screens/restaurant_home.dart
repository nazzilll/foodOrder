import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/model/popular_item_model.dart';
import 'package:flutter_eatit_new/screens/menu.dart';
import 'package:flutter_eatit_new/screens/restaurant_home_detail.dart';
import 'package:flutter_eatit_new/state/main_state.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../strings/restaurant_home_strings.dart';
import '../widgets/common/common_widgets.dart';


class RestaurantHome extends StatelessWidget {
  final drawerZoomController = ZoomDrawerController();
  final FirebaseApp app;
  final User user;

  RestaurantHome({required this.app, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ZoomDrawer(
          controller: drawerZoomController,
          menuScreen: MenuScreen(drawerZoomController, app, user),
          mainScreen: RestaurantHomeDetail(drawerZoomController),
          borderRadius: 24,
          showShadow: true,
          angle: 0.0,
          // menuBackgroundColor: Colors.grey[900]!,
          slideWidth: MediaQuery.of(context).size.width * 0.65,
          openCurve: Curves.bounceInOut,
          closeCurve: Curves.ease,
        ),
      ),
    );
  }
}
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/state/category_state.dart';
import 'package:flutter_eatit_new/state/food_detail_state.dart';
import 'package:flutter_eatit_new/state/food_list_state.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/const.dart';
import '../model/size_model.dart';
import '../strings/food_list_string.dart';
import '../utils/utils.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/food_detail/food_detail_description_widget.dart';
import '../widgets/food_detail/food_detail_image_widget.dart';
import '../widgets/food_detail/food_detail_name_widget.dart';
import 'package:flutter_eatit_new/strings/food_detail_strings.dart';

import '../widgets/food_detail/food_detail_size_widget.dart';

class FoodDetailScreen extends StatelessWidget {
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController = Get.find();
  final FoodDetailStateController foodDetailStateController =
      Get.put(FoodDetailStateController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  '${foodListStateController.selectedFood.value.name}',
                  style: GoogleFonts.jetBrainsMono(color: Colors.black),
                ),
                elevation: 10,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                foregroundColor: Colors.black,
                bottom: PreferredSize(
                  preferredSize: Size.square(foodDetailImageAreaSize(context)),
                  child: FoodDetailImageWidget(
                      foodListStateController: foodListStateController),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FoodDetailNameWidget(
                    foodDetailStateController: foodDetailStateController,
                    foodListStateController: foodListStateController),
                FoodDetailDescriptionWidget(
                    foodListStateController: foodListStateController),
                FoodDetailSizeWidget(
                    foodListStateController: foodListStateController,
                    foodDetailStateController: foodDetailStateController),
                Card(
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                              () => ExpansionTile(
                            title: Text(
                              addonText,
                              style: GoogleFonts.jetBrainsMono(
                                //color: Colors.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: foodListStateController
                                      .selectedFood.value.addon
                                      .map((e) => ChoiceChip(label: Text(e.name), selected: false))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

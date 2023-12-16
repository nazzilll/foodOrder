import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/model/category_model.dart';
import 'package:flutter_eatit_new/state/category_state.dart';
import 'package:flutter_eatit_new/state/main_state.dart';
import 'package:flutter_eatit_new/strings/restaurant_home_strings.dart';
import 'package:flutter_eatit_new/view_model/category_vm/category_view_model_imp.dart';
import 'package:flutter_eatit_new/widgets/common/appbar_with_cart_widget.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/category/category_list_widget.dart';

class CategoryScreen extends StatelessWidget {
  final viewModel = CategoryViewModelImp();
  final MainStateController mainStateController = Get.find();
  final CategoryStateController categoryStateController = Get.put(CategoryStateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithCartButton(title: '$categoriesText of ${mainStateController.selectedRestaurant.value.name}',),
        body: FutureBuilder(
          future: viewModel.displayCategoryByRestaurantId(
              mainStateController.selectedRestaurant.value.restaurantId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var lst = snapshot.data as List<CategoryModel>;

              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: CategoryListWidget(lst: lst,categoryStateController: categoryStateController,),
              );
            }
          },
        ));
  }
}



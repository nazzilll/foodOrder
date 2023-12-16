import 'package:flutter_eatit_new/model/category_model.dart';
import 'package:get/get.dart';

class CategoryStateController extends GetxController{
  var selectedCategory = CategoryModel(name: 'name', image: 'image', foods: []).obs;
}
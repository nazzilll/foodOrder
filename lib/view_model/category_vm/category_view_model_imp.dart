import 'package:flutter_eatit_new/firebase/category_references.dart';
import 'package:flutter_eatit_new/model/category_model.dart';

import 'category_view_model.dart';

class CategoryViewModelImp implements CategoryViewModel {
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurantId(
      String restaurantId) {
    return getCategoryByRestaurantId(restaurantId);
  }
}

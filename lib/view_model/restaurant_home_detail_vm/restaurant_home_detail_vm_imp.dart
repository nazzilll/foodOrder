import 'package:flutter_eatit_new/firebase/best_deals_references.dart';
import 'package:flutter_eatit_new/firebase/popular_reference.dart';
import 'package:flutter_eatit_new/model/popular_item_model.dart';
import 'package:flutter_eatit_new/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';

class RestaurantHomeDetailViewModelImp implements RestaurantHomeDetailViewModel{
  @override
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(String restaurantId) {
    return getMostPopularByRestaurantId(restaurantId);
  }

  @override
  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(String restaurantId) {
    return getBestDealByRestaurantId(restaurantId);
  }


}
import 'package:flutter_eatit_new/firebase/restaurant_reference.dart';
import 'package:flutter_eatit_new/view_model/main_vm/main_view_model.dart';

import '../../model/restaurant_model.dart';

class MainViewModelImp implements MainViewModel{
  @override
  Future<List<RestaurantModel>> displayRestaurantList(){
    return getRestaurantList();
  }
}

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit_new/const/const.dart';
import 'package:flutter_eatit_new/model/restaurant_model.dart';

Future<List<RestaurantModel>> getRestaurantList() async{
  var list = List<RestaurantModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance.ref().child(RESTAURANT_REF).once();
  RestaurantModel? restaurantModel;
  (source.snapshot.value as Map<dynamic,dynamic>).forEach((key, value) {
    restaurantModel = RestaurantModel.fromJson(jsonDecode(jsonEncode(value)));
    restaurantModel!.restaurantId = key;
    list.add(restaurantModel!);
  });


  return list;
}

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit_new/const/const.dart';
import 'package:flutter_eatit_new/model/popular_item_model.dart';

Future<List<PopularItemModel>> getMostPopularByRestaurantId(
    String restaurantId) async{
  var list = List<PopularItemModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(MOST_POPULAR_REF)
      .once();

  (source.snapshot.value as Map<dynamic,dynamic>).forEach((key, value) {
    list.add(PopularItemModel.fromJson(jsonDecode(jsonEncode(value))));
  });


  return list;
}
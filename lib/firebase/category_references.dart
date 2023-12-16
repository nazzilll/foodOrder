
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit_new/model/category_model.dart';
import '../const/const.dart';

Future<List<CategoryModel>> getCategoryByRestaurantId(
    String restaurantId) async{
  var list = List<CategoryModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .ref()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(CATEGORY_REF)
      .once();

  (source.snapshot.value as Map<dynamic,dynamic>).forEach((key, value) {
    list.add(CategoryModel.fromJson(jsonDecode(jsonEncode(value))));
  });


  return list;
}
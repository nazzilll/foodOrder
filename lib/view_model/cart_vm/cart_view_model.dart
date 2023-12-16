import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/model/cart_model.dart';
import 'package:flutter_eatit_new/state/cart_state.dart';

abstract class CartViewModel{
  void updateCart(CartStateController controller,int index,int value);
  void deleteCart(CartStateController controller,int index);
  void clearCart(CartStateController controller);

}
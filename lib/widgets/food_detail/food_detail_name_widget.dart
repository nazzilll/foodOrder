import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/state/food_detail_state.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state/food_list_state.dart';

class FoodDetailNameWidget extends StatelessWidget {
  const FoodDetailNameWidget(
      {super.key,
      required this.foodListStateController,
      required this.foodDetailStateController});

  final FoodListStateController foodListStateController;
  final FoodDetailStateController foodDetailStateController;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${foodListStateController.selectedFood.value.name}',
              style: GoogleFonts.jetBrainsMono(
                  //color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${foodListStateController.selectedFood.value.price}',
                  style: GoogleFonts.jetBrainsMono(
                    //color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                Obx(()=>ElegantNumberButton(
                  initialValue: foodDetailStateController.quantity.value,
                  minValue: 1,
                  maxValue: 100,
                  color: Colors.yellow,
                  onChanged: (value) {
                    print('Clicked $value');
                    foodDetailStateController.quantity.value = value.toInt();
                  },
                  decimalPlaces: 0,

                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/model/cart_model.dart';
import 'package:flutter_eatit_new/state/cart_state.dart';
import 'package:flutter_eatit_new/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CartInfo extends StatelessWidget {
  const CartInfo({
    super.key,
    required this.cartModel,
  });

  final CartModel cartModel;


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                cartModel.name,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.monetization_on,
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(width: 4,),
                  Text(
                    '${currencyFormat.format(cartModel.price)}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../infraestructure/checkout_provider.dart';

class PayButton extends StatelessWidget {
  const PayButton({Key? key, required this.cart}) : super(key: key);
  final CatalogCartAndCheckout cart;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {
          cart.pay(context);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          "Pagar",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

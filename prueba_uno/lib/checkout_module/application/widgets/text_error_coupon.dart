import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../infraestructure/checkout_provider.dart';

class TextErrorCoupon extends StatelessWidget {
  const TextErrorCoupon({Key? key, required this.cart}) : super(key: key);
  final CatalogCartAndCheckout cart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Cupón ${cart.coupon!.code} aplicado",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            cart.coupon = null;
            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
            cart.notifyListeners();
          },
          icon: const Icon(Icons.delete),
          color: Colors.grey,
        )
      ],
    );
  }
}

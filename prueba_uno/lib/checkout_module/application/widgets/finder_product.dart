import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../infraestructure/checkout_provider.dart';

class FinderProduct extends StatelessWidget {
  const FinderProduct({Key? key, required this.cart}) : super(key: key);
  final CatalogCartAndCheckout cart;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _tc = TextEditingController();
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    );
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: _tc,
                  decoration: InputDecoration(
                    hintText: "Cupón",
                    isDense: true,
                    enabledBorder: inputBorder,
                    border: inputBorder,
                    errorBorder: inputBorder,
                    focusedBorder: inputBorder,
                    disabledBorder: inputBorder,
                    focusedErrorBorder: inputBorder,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  cart.getCoupon(_tc.text);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("Aplicar"),
              ),
            ),
          ],
        ),
        if (cart.error != null)
          Text(
            cart.error!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          )
      ],
    );
  }
}

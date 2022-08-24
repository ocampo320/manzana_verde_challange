import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../checkout_module/infraestructure/checkout_provider.dart';
import '../../models/product.dart';

class ProductButton extends StatelessWidget {
  const ProductButton({Key? key, required this.appController, required this.product}) : super(key: key);
final CatalogCartAndCheckout appController;
final Product product;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ElevatedButton(
        key: const Key('challenge_add_btn'),
        onPressed: () {
          var count = appController.products
              .where((element) => element.selected == 1);
          if (count.length >= 3) {
            if (count.any((element) =>
            element.id == product.id && element.selected == 1)) {
              appController.addProduct(product);
            }
            return;
          }
          appController.addProduct(product);
        },
        child: const Text("Agregar"),
      ),
    );
  }
}

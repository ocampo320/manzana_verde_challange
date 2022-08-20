import 'package:flutter/material.dart';
import '../../../checkout_module/infraestructure/checkout_provider.dart';
import '../../models/product.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key, required this.product, required this.appController}) : super(key: key);
final Product product;
final CatalogCartAndCheckout appController;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (product.quantity == 1) {
                product.selected = 0;
                var count = appController.products
                    .where((element) => element.selected == 1);
                appController.sum = count.length;
              }
              if ((product.quantity ?? 0) > 0) {
                appController.removeProduct(product);
              }
            },
            icon: const Icon(Icons.remove),
          ),
          const Spacer(),
          Text(product.quantity.toString()),
          const Spacer(),
          IconButton(
            onPressed: () {
              var count = appController.products
                  .where((element) => element.selected == 1);
              // EL cliente solo puede agregar 3 tipos productos por compra,
              if (count.length >= 3) {
                if (count.any((element) =>
                element.id == product.id &&
                    element.selected == 1)) {
                  appController.addProduct(product);
                }
                return;
              }
              appController.addProduct(product);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

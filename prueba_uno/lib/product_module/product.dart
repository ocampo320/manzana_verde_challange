import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:separate_api/product_module/application/widgets/counter_widget.dart';

import '../checkout_module/infraestructure/checkout_provider.dart';
import 'models/product.dart';
import 'application/widgets/product_button.dart';

class ProductCartW extends StatelessWidget {
  const ProductCartW({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Color(0xff2d2d2d),
            ),
          ),
        ),
        Text(
          "\$ ${product.price}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ProductW extends StatelessWidget {
  const ProductW({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    var appController = Provider.of<CatalogCartAndCheckout>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Text(
              product.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff2d2d2d),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AspectRatio(
                aspectRatio: 5 / 3,
                child: Image.asset(
                  "assets/${product.image}.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Si el producto esta seleccionado entonces muestra el contador
            product.selected == 1
                ? CounterWidget(
                    product: product,
                    appController: appController,
                  )
                : ProductButton(
                    appController: appController,
                    product: product,
                  ),
          ],
        ),
      ),
    );
  }
}

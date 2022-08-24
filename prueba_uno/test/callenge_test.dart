import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:separate_api/checkout_module/application/widgets/pay_button.dart';
import 'package:separate_api/checkout_module/checkout.dart';
import 'package:separate_api/checkout_module/infraestructure/checkout_provider.dart';
import 'package:separate_api/product_module/models/product.dart';

void main() {
  late List<Product> products;
  late Product product;
  late Map<String, dynamic> couponsDb;
  late CatalogCartAndCheckout catalogCartAndCheckout;
  late Widget sut;

  setUp(() async {
    products = [
      Product(1, 1, 'Bolsa', 'Bolsa', 300, 2, false,null),
      Product(1, 2, 'Camara', 'Camara', 140, 2, false,  [3, 6])
    ];
    product = Product(1, 4, 'Bicicleta', 'Bicicleta', 100, 3, true, null);

    couponsDb = {
      "PORCENTAJE": {
        "id": 1,
        "code": "PORCENTAJE",
        "description": "10% de descuento en el total de tu compra",
        "type": "DISCOUNT_PERCENTAGE",
        "payload": {
          "value": 10,
          "minimum": 1000,
        },
      },
    };
    catalogCartAndCheckout = CatalogCartAndCheckout();

    sut= Scaffold(body:CheckoutPage() );
  });

  test('removeProduct', () async {
    catalogCartAndCheckout.removeProduct(product);
    catalogCartAndCheckout.calculateCoupon(catalogCartAndCheckout.subTotal!);
  });

  test('calculateSubtotal', () {
    catalogCartAndCheckout.products = products;
    catalogCartAndCheckout.findMatch(products.first);

    catalogCartAndCheckout.validatePromotion(product);

    expect(200.0, catalogCartAndCheckout.subTotal);
  });

  test('calculateCoupon', () {
    catalogCartAndCheckout.getCoupon('FIJO');
    catalogCartAndCheckout.cupon = {
      'code': 'FIJO',
      "payload": {
        "value": 10,
        "minimum": 700,
      },
    };
    catalogCartAndCheckout.calculateCoupon(700);
  });
  

}

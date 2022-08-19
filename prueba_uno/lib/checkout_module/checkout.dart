import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application/widgets/checkout_product_line.dart';
import 'application/widgets/finder_product.dart';
import 'application/widgets/pay_button.dart';
import 'application/widgets/section_for_values.dart';
import 'application/widgets/text_error_coupon.dart';
import 'application/widgets/text_for_value_section.dart';
import 'infraestructure/checkout_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ScrollController _sc = ScrollController();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 200));
      _sc.animateTo(_sc.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
    super.initState();
  }

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.grey.shade400,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pago")),
      body: Consumer<CatalogCartAndCheckout>(
        builder: (context, cart, child) {
          cart.calculateSubtotal();
          return SingleChildScrollView(
            controller: _sc,
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ///Lista de prodcutos.
                Wrap(
                  runSpacing: 20,
                  children: cart.products
                      .where((element) => element.selected == 1)
                      .map((e) {
                    return CheckoutProductLine(product: e);
                  }).toList(),
                ),
                const Divider(height: 50),
                cart.coupon == null
                    ? FinderProduct(
                        cart: cart,
                      )
                    : TextErrorCoupon(
                        cart: cart,
                      ),
                const Divider(height: 50),
                 SectionForValues(cart: cart),
                const Divider(height: 50),
                 TextForValueSection(
                  firstText: 'Total',
                  secondText: cart.total.toString(),
                ),
                const Divider(height: 50),
                PayButton(
                  cart: cart,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}



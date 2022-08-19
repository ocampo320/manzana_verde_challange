import 'package:flutter/cupertino.dart';
import 'package:separate_api/checkout_module/application/widgets/text_for_value_section.dart';

import '../../infraestructure/checkout_provider.dart';

class SectionForValues extends StatelessWidget {
  const SectionForValues({Key? key, required this.cart}) : super(key: key);
  final CatalogCartAndCheckout cart;

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      runSpacing: 15,
      children:  [
        TextForValueSection(firstText:'Subtotal' ,secondText: cart.subTotal.toString(),),
        TextForValueSection(firstText:'Descuento por cupón' ,secondText: cart.couponDiscount.toString(),),
        TextForValueSection(firstText:'Costo de envío' ,secondText: cart.deliveryCost.toString(),)
      ],
    );
  }
}

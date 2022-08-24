
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final cartBtn=find.byKey(const Key('challenge_home_cart_btn'));
final shopListProduct=find.byType(TextField).first;
//final btnApply=find.byKey(const Key('challenge_checkout_btn_apply'));
final btnApply=find.byType(ElevatedButton).first;
final addProduct=find.byKey(const Key('challenge_add_btn'));
final shopSection=find.byKey(const Key('challenge_shop_section'));
final shopSectionList=find.byKey(const Key('challenge_shop_list_product'));
final shopProductW=find.byKey(const Key('challenge_shop_prodcutW'));
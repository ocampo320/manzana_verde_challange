import 'package:flutter/cupertino.dart';

import '../../app_controller.dart';
import '../../product.dart';
import '../../services.dart';

class CatalogCartAndCheckout extends ChangeNotifier {
  List<Product> products = [];
  Coupon? coupon;
  int? sum;
  String? error;
  double  _subTotal=0;
  double _couponDiscount=0;
  double _deliveryCost=0;


  double get deliveryCost => _deliveryCost;

  set deliveryCost(double value) {
    _deliveryCost = value;
  }

  double get couponDiscount => _couponDiscount;

  set couponDiscount(double value) {
    _couponDiscount = value;
  }

  double get subTotal => _subTotal;

  set subTotal(double value) {
    _subTotal = value;
  }

  init() async {
    await fetchProducts();
  }

  fetchProducts() async {
    var products = await Services().getProducts();
    products = products["result"];
    this.products = (products as List).map(
          (e) {
        var product = Product.fromJson(e);
        product.selected = 0;
        return product;
      },
    ).toList();
    notifyListeners();
  }

  addProduct(Product product) {
    var productInList = products.firstWhere(
          (element) => element.id == product.id,
    );
    var count = products.where((element) => element.selected == 1);
    sum = count.length;
    productInList.selected = 1;
    productInList.quantity = (productInList.quantity ?? 0) + 1;
    notifyListeners();
  }

  removeProduct(Product product) {
    product.quantity = product.quantity! - 1;
    var count = products.where((element) => element.selected == 1);
    sum = count.length;
    notifyListeners();
  }

  checkPrices() {
    for (var i = 0; i < products.length; i++) {
      products[i].selected = 0;
      products[i].quantity = 0;
    }
  }

  calculateTotal() {
    // TODO: Implementar algoritmo para calcular total
  }

  getCoupon(String code) async {
    error = null;
    var cupon = await Services().getCoupon(code);
    cupon = cupon["result"];
    if (cupon != null) {
      coupon = Coupon.fromJson(cupon);
      notifyListeners();
    } else {
      error = "El cupón no existe";
      notifyListeners();
    }
  }

  clearCart() {
    for (var i = 0; i < products.length; i++) {
      products[i].selected = 0;
      products[i].quantity = 0;
    }
    notifyListeners();
  }

  pay(BuildContext context) {
    clearCart();
    coupon = null;
    Navigator.of(context).pop();
  }


}
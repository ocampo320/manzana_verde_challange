import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_controller.dart';
import '../../product.dart';
import '../../services.dart';


class CatalogCartAndCheckout extends ChangeNotifier {
  List<Product> products = [];
  Coupon? coupon;
  int? sum;
  String? error;
  double? _subTotal;
  double _couponDiscount = 0;
  int _deliveryCost = 0;
  double _total=0 ;
  double  _couponPercentage=0;

  double get couponPercentage => _couponPercentage;

  set couponPercentage(double value) {
    _couponPercentage = value;
  }

  var _cupon;

  get cupon => _cupon;

  set cupon(value) {
    _cupon = value;
  }

  double? get couponPermanent => _couponPermanent;



  set couponPermanent(double? value) {
    _couponPermanent = value;
  }



  double? _couponPermanent;

  double get total => _total;

  set total(double value) {
    _total = value;
    notifyListeners();
  }

  int get deliveryCost => _deliveryCost;

  set deliveryCost(int value) {
    _deliveryCost = value;
  }

  double get couponDiscount => _couponDiscount;

  set couponDiscount(double value) {
    _couponDiscount = value;
    notifyListeners();
  }

  double? get subTotal => _subTotal;

  set subTotal(double? value) {
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
    calculateCoupon(subTotal!);
    couponPercentage != null
        ? total = (subTotal! - couponPercentage)

        : total = (subTotal! - couponPermanent!);
  }

  getCoupon(String code) async {
    error = null;
    cupon= await Services().getCoupon(code);
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

//Calcular subtotal de la lista de prodcutos.
  void calculateSubtotal() {
    int? subtotalForProduct = 0;
    subTotal = 0;
    for (var element in products) {
      if (element.selected == 1) {
        subtotalForProduct = element.price! * element.quantity!;
        subTotal = subTotal! + subtotalForProduct;
      }
    }
  }

  ///Calcula el valor del descuento por cupon segun su tipo
  ///PORCENTAJE
  ///FIJO
  void calculateCoupon(double subtotal) {
    if (_cupon!=null) {
      switch (_cupon!['code']) {
        case 'PORCENTAJE':
          {
            couponPercentage = ((subtotal * (_cupon!['payload']['value'] / 100))) ;

          }
          break;
        case 'FIJO':
          {
            couponPermanent = _cupon!['payload']['value'];

          }
          break;
      }
    }
  }

  void validateTypeCoupon() {}
}
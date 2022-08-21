import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/coupon.dart';
import '../../product_module/product_page.dart';
import 'services/services.dart';
import '../../product_module/models/product.dart';


class CatalogCartAndCheckout extends ChangeNotifier {
  List<Product> products = [];
  Coupon? coupon;
  int? sum;
  String _error='';

  String  get error => _error;

  set error(String value) {
    _error = value;
    notifyListeners();
  }

  double? _subTotal;
  double _couponDiscount = 0;
  int _deliveryCost = 0;
  double? _total ;
  double  _couponPercentage=0;
  dynamic _valueCoupon;

  dynamic get valueCoupon => _valueCoupon;

  set valueCoupon(dynamic value) {
    _valueCoupon = value;
  }

  double get couponPercentage => _couponPercentage;

  set couponPercentage(double value) {
    _couponPercentage = value;
  }

  var _cupon;

  get cupon => _cupon;

  set cupon(value) {
    _cupon = value;
  }


  dynamic _couponPermanent;

  dynamic get couponPermanent => _couponPermanent;

  set couponPermanent(dynamic value) {
    _couponPermanent = value;
  }

  double ?get total => _total;

  set total(double? value) {
    _total = value;
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

 void  calculateTotal() {
    if(_cupon!=null){
      calculateCoupon(subTotal!);
    }
  }
  void calculateTotalOutCoupon(){
    total=(subTotal);
  }


  getCoupon(String code) async {
    error = '';
    cupon= await Services().getCoupon(code);
    cupon = cupon["result"];
   calculateTotal();
    if (cupon != null) {
      coupon = Coupon.fromJson(cupon);

    } else {
      error = "El cupón no existe";

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
      switch (_cupon!['code']) {
        case 'PORCENTAJE':
          {
            if(subtotal>=_cupon!['payload']['minimum']){
              valueCoupon = ((subtotal * (_cupon!['payload']['value'] / 100))) ;
              total = (subTotal! - valueCoupon);
            }else{
              error='No cumple con las condiciones';
            }
          }
          break;
        case 'FIJO':
          {
            if(subtotal>=_cupon!['payload']['minimum']){
              valueCoupon = _cupon!['payload']['value'];
              total = (subTotal! - valueCoupon);
            }else{
              error='No cumple con las condiciones';
            }
          }
          break;
        default: {
          total=total;
        }
      }

  }

  void calculateTotalWithCoupon(int subtotal,Map<String,dynamic> coupon){



  }

  void validateCoupon() {



  }
}
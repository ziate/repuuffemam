import 'package:efood_multivendor/data/model/response/cart_model.dart';
import 'package:efood_multivendor/data/repository/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({@required this.cartRepo});

  List<CartModel> _cartList = [];
  double _amount = 0.0;

  List<CartModel> get cartList => _cartList;
  double get amount => _amount;

  Future<void> getCartData(bool reload, String storeId) async {
    _loading(true);
    Response response = await cartRepo.getCartList(storeId);
    if (response.statusCode == 200) {
      _cartList = [];
      // _interestSelectedList = [];
      var bodyList = response.body["data"] as List;
      bodyList.forEach((cart) {
        _cartList.add(CartModel.fromJson(cart));
        // _interestSelectedList.add(false);
      });
      _loading(false);
    } else {
      _loading(false);
      ApiChecker.checkApi(response);
    }
    update();
  }
  // void getCartData() {
  //   _cartList = [];
  //   _cartList.addAll(cartRepo.getCartList());
  //   _cartList.forEach((cart) {
  //     _amount = _amount + (cart.discountedPrice * cart.quantity);
  //   });
  // }

  void addToCart(CartModel cartModel, String shopId, int amount) {
    // if (index != null) {
    //   _amount = _amount -
    //       (_cartList[index].discountedPrice * _cartList[index].quantity);
    //   _cartList.replaceRange(index, index + 1, [cartModel]);
    // } else {
    //   _cartList.add(cartModel);
    // }
    // _amount = _amount + (cartModel.discountedPrice * cartModel.quantity);
    cartRepo.addToCartList(cartModel, shopId);
    update();
  }

  void setQuantity(bool isIncrement, CartModel cart, String shopId) {
    int index = _cartList.indexOf(cart);
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _amount = _amount + _cartList[index].discountedPrice;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _amount = _amount - _cartList[index].discountedPrice;
    }
    cartRepo.addToCartList(_cartList, shopId);

    update();
  }

  void removeFromCart(int index) {
    _amount = _amount -
        (_cartList[index].discountedPrice * _cartList[index].quantity);
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    update();
  }

  void removeAddOn(int index, int addOnIndex) {
    _cartList[index].addOnIds.removeAt(addOnIndex);
    cartRepo.addToCartList(_cartList);
    update();
  }

  void clearCartList() {
    _cartList = [];
    _amount = 0;
    cartRepo.addToCartList(_cartList);
    update();
  }

  bool isExistInCart(CartModel cartModel, bool isUpdate, int cartIndex) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].product.id == cartModel.product.id &&
          (_cartList[index].variation.length > 0
              ? _cartList[index].variation[0].type ==
                  cartModel.variation[0].type
              : true)) {
        if ((isUpdate && index == cartIndex)) {
          return false;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  bool existAnotherRestaurantProduct(int restaurantID) {
    for (CartModel cartModel in _cartList) {
      if (cartModel.product.restaurantId != restaurantID) {
        return true;
      }
    }
    return false;
  }

  void removeAllAndAddToCart(CartModel cartModel) {
    _cartList = [];
    _cartList.add(cartModel);
    _amount = cartModel.discountedPrice * cartModel.quantity;
    cartRepo.addToCartList(_cartList);
    update();
  }

  bool isLoading = false;
  void _loading(bool status) {
    isLoading = status;
    update();
  }
}

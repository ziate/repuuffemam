import 'dart:convert';

import 'package:efood_multivendor/data/model/response/cart_model.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  CartRepo({
    @required this.sharedPreferences,
    @required this.apiClient,
  });

  Future<Response> getCartList(String storeId) async {
    return await apiClient.getData("${AppConstants.CARTLIST_URI}$storeId");
    // return
    // List<String> carts = [];
    // if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
    //   carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    // }
    // List<CartModel> cartList = [];
    // carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))));
    // return cartList;
  }

  Future<Response> addToCartList(CartModel cartModel, String storeId) async {
    return await apiClient.postData(
        "${AppConstants.CARTLIST_URI}$storeId", cartModel.toJson());
    // List<String> carts = [];
    // cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
    // sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }
}

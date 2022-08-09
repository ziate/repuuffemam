import 'dart:developer';

import 'package:efood_multivendor/data/api/api.dart';
import 'package:efood_multivendor/data/model/body/used_market_product_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsedMarketController extends GetxController implements GetxService {
  XFile _pickedFile;
  bool _isLoading = false;
  List<UsedMarketProductModel> _products = [];

  XFile get pickedFile => _pickedFile;

  bool get isLoading => _isLoading;
  List<UsedMarketProductModel> get products => _products;

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  void initData() {
    _pickedFile = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void getUsedMarketProducts() async {
    SharedPreferences _sharedData = await SharedPreferences.getInstance();
    String token = _sharedData.get(AppConstants.TOKEN);
    log('token is : $token');

    try {
      Map dataReturned = await API()
          .getRequest(url: AppConstants.USED_MARKET_PRODUCTS_URI, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      });

      log(dataReturned.toString());
      List listOfProductsJson = [];
      listOfProductsJson = dataReturned['data'];
      log(listOfProductsJson.toString());
      print("-----------------------------------------------------");
      log(listOfProductsJson.toString());
      for (int i = 0; i < listOfProductsJson.length; i++) {
        _products.add(
          UsedMarketProductModel(
            id: listOfProductsJson[i]['id'],
            address: listOfProductsJson[i]['address'],
            name: listOfProductsJson[i]['name'],
            description: listOfProductsJson[i]['description'],
            phone: listOfProductsJson[i]['phone'],
            price: listOfProductsJson[i]['price'],
            image: listOfProductsJson[i]['image'],
          ),
        );
      }
      update();
    } catch (e, t) {
      log("Error in getUsedMarketProducts in category controller $e");
      print(t);
    }
  }

  void addUsedProduct(
      {String name,
      String description,
      String phone,
      String address,
      String price}) async {
    SharedPreferences _sharedData = await SharedPreferences.getInstance();
    String token = _sharedData.get(AppConstants.TOKEN);
    try {
      Map dataReturned = await API()
          .postRequest(url: AppConstants.ADD_USED_PRODUCT_URI, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      }, body: {
        'name': name,
        'description': description,
        'price': price,
        'phone': phone,
        'address': address,
      });

      log(dataReturned.toString());
      if (dataReturned['msg'] == 'success') {
        Get.to(DashboardScreen(pageIndex: 0));
        Get.snackbar(
            'product_added_successfully'.tr, dataReturned['data'] ?? '');
      } else {
        Get.snackbar('Error!! try again'.tr, dataReturned['data'] ?? '');
      }

      update();
    } catch (e, t) {
      Get.snackbar('Product not added', 'There is a problem, try again later');
      log("Error in getUsedMarketProducts in category controller $e");
      print(t);
    }
  }
}

import 'dart:developer';

import 'package:efood_multivendor/data/api/api.dart';
import 'package:efood_multivendor/data/api/api_checker.dart';
import 'package:efood_multivendor/data/model/body/brand_model.dart';
import 'package:efood_multivendor/data/model/response/category_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/data/repository/category_repo.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  final BuildContext context;
  CategoryController({@required this.categoryRepo, @required this.context});

  List<CategoryModel> _categoryList;
  List<CategoryModel> _subCategoryList;
  List<Product> _categoryProductList = [];
  List<Restaurant> _categoryRestList;
  List<Product> _searchProductList = [];
  List<Restaurant> _searchRestList = [];
  List<bool> _interestSelectedList;
  bool _isLoading = false;
  int _pageSize;
  int _restPageSize;
  bool _isSearching = false;
  int _subCategoryIndex = 0;
  String _type = 'all';
  bool _isRestaurant = false;
  String _searchText = '';
  String _restResultText = '';
  String _prodResultText = '';
  int _offset = 1;
  String shopId;
  List<Brand> _brands = [];

  List<CategoryModel> get categoryList => _categoryList;
  List<CategoryModel> get subCategoryList => _subCategoryList;
  List<Product> get categoryProductList => _categoryProductList;
  List<Restaurant> get categoryRestList => _categoryRestList;
  List<Product> get searchProductList => _searchProductList;
  List<Restaurant> get searchRestList => _searchRestList;
  List<bool> get interestSelectedList => _interestSelectedList;
  bool get isLoading => _isLoading;
  int get pageSize => _pageSize;
  int get restPageSize => _restPageSize;
  bool get isSearching => _isSearching;
  int get subCategoryIndex => _subCategoryIndex;
  String get type => _type;
  bool get isRestaurant => _isRestaurant;
  String get searchText => _searchText;
  int get offset => _offset;
  List<Brand> get brands => _brands;

  Future<void> getCategoryList(bool reload) async {
    if (_categoryList == null || reload) {
      Response response = await categoryRepo.getCategoryList();
      if (response.statusCode == 200) {
        _categoryList = [];
        _interestSelectedList = [];
        response.body.forEach((category) {
          _categoryList.add(CategoryModel.fromJson(category));
          _interestSelectedList.add(false);
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

// ------------------------------------------- TODO ----------------------------------
  void getBrans() async {
    //------------------------ TODO --------------------------------------------------
    try {
      Map dataReturned = await API()
          .getRequest(url: AppConstants.BRANDS_URI, context: context);
      List listOfBrandsJson = dataReturned['data'];
      print("-----------------------------------------------------");
      log(listOfBrandsJson.toString());
      for (int i = 0; i < listOfBrandsJson.length; i++) {
        _brands.add(
          Brand(
            id: listOfBrandsJson[i]['id'],
            name: listOfBrandsJson[i]['name'],
            image: listOfBrandsJson[i]['img'],
          ),
        );
      }
      update();
    } catch (e, t) {
      log("Error in getBrands in category controller $e");
      print(t);
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error, try again later'),
      //   ),
      // );
    }
  }

  void getSubCategoryList(String categoryID, String shopId, int brandId) async {
    _subCategoryIndex = 0;
    _subCategoryList = null;
    _categoryProductList = null;
    Response response = await categoryRepo.getSubCategoryList(categoryID);
    if (response.statusCode == 200) {
      _subCategoryList = [];
      _subCategoryList
          .add(CategoryModel(id: int.parse(categoryID), name: 'all'.tr));
      response.body.forEach(
          (category) => _subCategoryList.add(CategoryModel.fromJson(category)));
      getCategoryProductList(categoryID, shopId, 1, 'all', false, brandId);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void setSubCategoryIndex(int index, String categoryID, String shopId) {
    _subCategoryIndex = index;
    if (_isRestaurant) {
      getCategoryRestaurantList(
          _subCategoryIndex == 0
              ? categoryID
              : _subCategoryList[index].id.toString(),
          1,
          _type,
          true);
    } else {
      getCategoryProductList(
          _subCategoryIndex == 0
              ? categoryID
              : _subCategoryList[index].id.toString(),
          shopId,
          1,
          _type,
          true,
          _brands[index].id);
    }
  }

  void getCategoryProductList(String categoryID, String shopId, int offset,
      String type, bool notify, int brandId) async {
    _offset = offset;
    if (offset == 1) {
      if (_type == type) {
        _isSearching = false;
      }
      _type = type;
      if (notify) {
        update();
      }
      _categoryProductList = null;
    }
    Response response = await categoryRepo.getCategoryProductList(
        categoryID, shopId, offset, type, brandId);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryProductList = [];
      }
      _categoryProductList
          .addAll(ProductModel.fromJson(response.body).products);
      _pageSize = ProductModel.fromJson(response.body).totalSize;
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getCategoryRestaurantList(
      String categoryID, int offset, String type, bool notify) async {
    _offset = offset;
    if (offset == 1) {
      if (_type == type) {
        _isSearching = false;
      }
      _type = type;
      if (notify) {
        update();
      }
      _categoryRestList = null;
    }
    Response response =
        await categoryRepo.getCategoryRestaurantList(categoryID, offset, type);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryRestList = [];
      }
      _categoryRestList
          .addAll(RestaurantModel.fromJson(response.body).restaurants);
      _restPageSize = ProductModel.fromJson(response.body).totalSize;
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void searchData(String query, String categoryID, String type) async {
    print(
        '-------${(_isRestaurant && query.isNotEmpty && query != _restResultText) || (!_isRestaurant && query.isNotEmpty && query != _prodResultText)}');
    if ((_isRestaurant && query.isNotEmpty && query != _restResultText) ||
        (!_isRestaurant && query.isNotEmpty && query != _prodResultText)) {
      _searchText = query;
      _type = type;
      if (_isRestaurant) {
        _searchRestList = null;
      } else {
        _searchProductList = null;
      }
      _isSearching = true;
      update();

      Response response = await categoryRepo.getSearchData(
          query, categoryID, _isRestaurant, type);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          if (_isRestaurant) {
            _searchRestList = [];
          } else {
            _searchProductList = [];
          }
        } else {
          if (_isRestaurant) {
            _restResultText = query;
            _searchRestList = [];
            _searchRestList
                .addAll(RestaurantModel.fromJson(response.body).restaurants);
          } else {
            _prodResultText = query;
            _searchProductList = [];
            _searchProductList
                .addAll(ProductModel.fromJson(response.body).products);
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchProductList = [];
    if (_categoryProductList != null) {
      _searchProductList.addAll(_categoryProductList);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<bool> saveInterest(List<int> interests) async {
    _isLoading = true;
    update();
    Response response = await categoryRepo.saveUserInterests(interests);
    bool _isSuccess;
    if (response.statusCode == 200) {
      _isSuccess = true;
    } else {
      _isSuccess = false;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  void addInterestSelection(int index) {
    _interestSelectedList[index] = !_interestSelectedList[index];
    update();
  }

  void setRestaurant(bool isRestaurant) {
    _isRestaurant = isRestaurant;
    update();
  }
}

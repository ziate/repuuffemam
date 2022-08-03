import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/coupon_controller.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/helper/date_converter.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/my_text_field.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:efood_multivendor/view/screens/cart/widget/cart_product_widget.dart';
import 'package:efood_multivendor/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final fromNav;
  CartScreen({@required this.fromNav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        titleWidget: Text(
          "my_cart".tr,
          style: TextStyle(color: Colors.white),
        ),
        isBackButtonExist: (ResponsiveHelper.isDesktop(context) || !fromNav),
        isSmallAppBar: true,
        onBackPressed: () {
          Get.to(DashboardScreen(pageIndex: 0));
        },
      ),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          List<List<AddOns>> _addOnsList = [];
          List<bool> _availableList = [];
          double _itemPrice = 0;
          double _addOns = 0;
          cartController.cartList.forEach((cartModel) {
            List<AddOns> _addOnList = [];
            cartModel.addOnIds.forEach((addOnId) {
              for (AddOns addOns in cartModel.product.addOns) {
                if (addOns.id == addOnId.id) {
                  _addOnList.add(addOns);
                  break;
                }
              }
            });
            _addOnsList.add(_addOnList);

            _availableList.add(DateConverter.isAvailable(
                cartModel.product.availableTimeStarts,
                cartModel.product.availableTimeEnds));

            for (int index = 0; index < _addOnList.length; index++) {
              _addOns = _addOns +
                  (_addOnList[index].price *
                      cartModel.addOnIds[index].quantity);
            }
            _itemPrice = _itemPrice + (cartModel.price * cartModel.quantity);
          });
          double _subTotal = _itemPrice + _addOns;
          double _delivery = 10;
          double _total = _delivery + _subTotal;

          return cartController.cartList.length > 0
              ? Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          physics: BouncingScrollPhysics(),
                          child: Center(
                            child: SizedBox(
                              width: Dimensions.WEB_MAX_WIDTH,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Color(0xff727c8e),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'order_summary'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: (() {
                                            cartController.clearCartList();
                                          }),
                                          child: Text(
                                            'remove_all'.tr,
                                            style: TextStyle(
                                                color: Color(0xff727c8e),
                                                fontSize: 12),
                                          ))
                                    ],
                                  ),
                                  // Product
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cartController.cartList.length,
                                    itemBuilder: (context, index) {
                                      return CartProductWidget(
                                          cart: cartController.cartList[index],
                                          cartIndex: index,
                                          addOns: _addOnsList[index],
                                          isAvailable: _availableList[index]);
                                    },
                                  ),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  Text(
                                    'Do_you_have_any_discount_code'.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 25,
                                    child: MyTextField(),
                                    width: MediaQuery.of(context).size.width *
                                        0.66,
                                  ),
                                  // Total
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('subtotal'.tr,
                                            style: TextStyle(
                                              color: Color(0xff727c8e),
                                            )),
                                        Text(
                                            PriceConverter.convertPrice(
                                                _subTotal),
                                            style: TextStyle(
                                              color: Color(0xff727c8e),
                                            )),
                                      ]),
                                  SizedBox(height: 10),

                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('delivery_charge'.tr,
                                            style: TextStyle(
                                              color: Color(0xff727c8e),
                                            )),
                                        Text(
                                            '(+) ${PriceConverter.convertPrice(_delivery)}',
                                            style: TextStyle(
                                              color: Color(0xff727c8e),
                                            )),
                                      ]),
                                  SizedBox(height: 10),

                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('total_price'.tr,
                                            style: TextStyle(
                                                color: Color(0xff727c8e),
                                                fontSize: 15)),
                                        Text(
                                          ' ${PriceConverter.convertPrice(_total)}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Divider(
                                        thickness: 1,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: CustomButton(
                          buttonText: 'proceed_to_checkout'.tr,
                          onPressed: () {
                            if (!cartController
                                    .cartList.first.product.scheduleOrder &&
                                _availableList.contains(false)) {
                              showCustomSnackBar(
                                  'one_or_more_product_unavailable'.tr);
                            } else {
                              Get.find<CouponController>()
                                  .removeCouponData(false);
                              Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
                            }
                          }),
                    ),
                  ],
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height * 0.33)),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "you_currently_have_no_orders".tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Best_get_shopping_now".tr,
                            style: TextStyle(
                                color: Color(0xff727c8e), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
          // NoDataScreen(isCart: true, text: '');
        },
      ),
    );
  }
}

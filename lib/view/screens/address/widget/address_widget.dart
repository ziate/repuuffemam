import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/theme/styles.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel address;
  final bool fromAddress;
  final bool fromCheckout;
  final Function onRemovePressed;
  final Function onEditPressed;
  final Function onTap;
  AddressWidget(
      {@required this.address,
      @required this.fromAddress,
      this.onRemovePressed,
      this.onEditPressed,
      this.onTap,
      this.fromCheckout = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: kTextColor),
              borderRadius: BorderRadius.all(Radius.circular(13))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                address.addressType.tr,
                style: robotoMedium.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Text(
                address.address,
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: kTextColor,
                ),
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              fromAddress
                  ? Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: ResponsiveHelper.isDesktop(context) ? 35 : 25,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

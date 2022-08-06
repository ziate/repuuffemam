import 'package:efood_multivendor/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "powered_by".tr,
            style: kTextStyleReg16.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(width: 23),
          Image.asset(
            "assets/image/joxx.png",
            width: 50,
          )
        ],
      ),
    );
  }
}

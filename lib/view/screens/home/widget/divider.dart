import 'package:flutter/material.dart';

Widget customDivider(BuildContext context) {
  double _width = MediaQuery.of(context).size.width;

  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: _width / 9),
      child: Divider(
        color: Color(0xffe1003c),
        height: 0,
        thickness: 2,
      ),
    ),
  );
}

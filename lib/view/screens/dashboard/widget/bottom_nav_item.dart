import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavItem extends StatelessWidget {
  final String iconData;
  final Function onTap;
  final bool isSelected;

  BottomNavItem({@required this.iconData, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        iconData,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
      ),
      onPressed: onTap,
    );
  }
}

import 'package:efood_multivendor/theme/styles.dart';
import 'package:flutter/material.dart';

import '../../profile/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 50),
      child: Drawer(
        elevation: 0,
        child: ProfileScreen(),
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }
}

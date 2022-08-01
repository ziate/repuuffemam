import 'package:flutter/material.dart';

class SharedButton extends StatelessWidget {
  final double width;
  final String text;
  final Color color;
  final void Function() onPressed;
  const SharedButton(
      {Key key,
      @required this.width,
      @required this.text,
      this.onPressed,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: color ?? const Color(0xff3ABEF0),
        border: Border.all(color: Colors.white, width: 0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
        minWidth: width,
        onPressed: onPressed,
      ),
    );
  }
}

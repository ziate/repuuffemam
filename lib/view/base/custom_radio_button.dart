import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  // final String label;
  final String text;
  final ValueChanged<T> onChanged;

  const MyRadioOption({
    @required this.value,
    @required this.groupValue,
    // @required this.label,
    @required this.text,
    @required this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Container(
      width: 25,
      height: 25,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        //color: isSelected ? Colors.cyan : Colors.white,
      ),
      child: Center(
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Container()
          //  Text(
          //   value.toString(),
          //   style: TextStyle(
          //     color: isSelected ? Colors.white : Colors.cyan,
          //     fontSize: 20,
          //   ),
          // ),
          ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Colors.cyan.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
              const SizedBox(width: 10),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }
}

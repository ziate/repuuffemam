import 'package:flutter/material.dart';

class FixedTextField extends StatelessWidget {
  const FixedTextField({Key key, this.onChanged}) : super(key: key);
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 45,
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: Color(0xFFE1E1E1),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                )),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/styles.dart';
import '../../util/app_constants.dart';
// import '../constants/styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.validator,
    this.hintText,
    this.labelText,
    this.onSaving,
    this.controller,
    this.isLongField = false,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);
  final Function(String) validator;
  final Function(String) onSaving;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool isLongField;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (v) => validator == null ? null : validator(v),
      onSaved: (v) => onSaving == null ? null : onSaving(v),
      maxLines: isLongField ? 4 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: kTextStyleRegGrey14,
        floatingLabelStyle: kTextStyleSemiBoldPrim16,
        border: AppConstants.decorationSignInScreen,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}

// final _outlineBorder = OutlineInputBorder(
//   borderSide: BorderSide(color: Colors.grey[100]!),
//   borderRadius: BorderRadius.circular(15),
// );

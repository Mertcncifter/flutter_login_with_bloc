import 'package:flutter/material.dart';

class ResourceConstants {
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Color appBG = Color.fromARGB(255, 247, 246, 242);

  static Color EditInvoiceScreensaveButtonBG = Color.fromARGB(255, 9, 58, 62);
  static Color textFormFieldColor = Colors.white;
  static Color textformFieldIconColor = Colors.grey;
  static Color textformFieldFocusBorderColor = Colors.black;
  static Color textformFieldDisableBorderColor = Colors.black;
  static Color textformFieldEnabledBorderColor = Colors.black;
  static Color textformFieldFocusedErrorBorderColor = Colors.black;
  static Color textformFieldErrorBorderColor = Colors.red;
  static TextStyle inputHintTextStyle = TextStyle(
      fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w500);
}

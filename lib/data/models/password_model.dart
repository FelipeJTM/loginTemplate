import 'package:flutter/widgets.dart';

class PasswordModel {
  final String labelText;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final bool willEnableSuffix;

  PasswordModel({
    required this.labelText,
    required this.passwordController,
    required this.repeatPasswordController,
    this.willEnableSuffix = false,
  });


}

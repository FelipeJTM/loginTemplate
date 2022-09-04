

import 'package:flutter/material.dart';

void nextScreenReplace(BuildContext context,Widget page){
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
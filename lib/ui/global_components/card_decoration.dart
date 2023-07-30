import 'package:flutter/material.dart';
import 'package:midlr/utils/size_config.dart';

BoxDecoration cardDecoration({Color? borderColor}) {
  return BoxDecoration(
    border: Border.all(color: borderColor ?? Colors.transparent),
    borderRadius: BorderRadius.circular(2.heightAdjusted),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.029999999329447746),
          offset: Offset(0, 4),
          blurRadius: 30)
    ],
  );
}

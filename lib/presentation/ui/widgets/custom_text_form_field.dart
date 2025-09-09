import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

SizedBox customTextFormField(TextEditingController controller, hintText, line) {
  return SizedBox(
    width: 300,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      maxLines: line,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppMainColor.primaryColor),
        ),
        filled: true,
        fillColor: Colors.white54,
      ),
    ),
  );
}

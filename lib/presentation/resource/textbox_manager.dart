import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:flutter/material.dart';

OutlineInputBorder outlinedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    25,
  ),
  borderSide: BorderSide(color: ColorManager.white),
);

OutlineInputBorder enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    25,
  ),
  borderSide: const BorderSide(color: Colors.blue),
);

OutlineInputBorder disabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    25,
  ),
  borderSide: BorderSide(color: ColorManager.grey),
);

OutlineInputBorder focuseBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    25,
  ),
  borderSide: const BorderSide(color: Colors.green),
);

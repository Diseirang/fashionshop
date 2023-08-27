import 'package:flutter/material.dart';

import '../resource/style_manager.dart';

Widget groupTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16, top: 16
      ),
      child: Text(
        text,
        style: getBoldStyle(fontSize: 22, color: Colors.blue),
      ),
    );
  }
// all_side_shadow_decoration.dart
import 'package:flutter/material.dart';

const BoxDecoration allSideShadowDecoration = BoxDecoration(
  color: Colors.white, // Background color of the container
  boxShadow: [
    BoxShadow(
      // color: Color.fromRGBO(228, 242, 228, 0.6), // Lighter green shadow color
      color: Color.fromRGBO(29, 191, 115, 0.1), // Lighter green shadow color
      blurRadius: 15, // Controls the softness of the shadow
      spreadRadius: 5, // Controls the spread of the shadow to all sides
      offset: Offset(
          0, 0), // No offset so that the shadow is spread equally on all sides
    ),
  ],
);

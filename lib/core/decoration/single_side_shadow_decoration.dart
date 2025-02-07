import 'package:flutter/material.dart';

const BoxDecoration greenShadowDecoration = BoxDecoration(
  color: Colors.white, // Background color
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(228, 242, 228, 0.6), // Lighter green shadow color
      blurRadius: 15, // Controls the softness of the shadow
      spreadRadius: 1, // Controls the spread of the shadow
      offset: Offset(0, 8), // Moves the shadow downward
    ),
  ],
);

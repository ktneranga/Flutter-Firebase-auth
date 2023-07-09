import 'package:firebase_auth_app/constants/colors.dart';
import 'package:flutter/material.dart';

const TextStyle descriptionStyle =
    TextStyle(fontSize: 12, color: textLight, fontWeight: FontWeight.w200);

const textInputtDecorations = InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(color: textLight),
  filled: true,
  fillColor: bgBlack,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/utils/hex_color.dart';

class UI {
  UI();

  // dimens
  static const paddingTop = EdgeInsets.only(top: 10);

  // texts
  static final textColor = HexColor.fromHex("292941");
  static final textStyle = TextStyle(color: textColor, fontSize: 14);

  // appBar
  static final appBarBackground = Colors.white;
  static final appBarTextColor = HexColor.fromHex("292941");
  static final appBarIconColor = appBarTextColor;
  static final appBarTextStyle = TextStyle(color: appBarTextColor);

  static final primaryColor = HexColor.fromHex("EB7E44");
  static final bodyBackground = Colors.white;

  /// text fields
  static final textDecoration = InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,

  );
  static final fieldBackground = Colors.white;
}

part of 'config.dart';

class UI {
  UI();

  // dimens
  static const paddingTop = EdgeInsets.only(top: 10);

  // texts
  static final textColor = HexColor.fromHex("292941");
  static final textStyle = TextStyle(color: textColor, fontSize: 14);

  // appBar
  static final appBarBackground = HexColor.fromHex("F7F7F9");
  static final appBarTextColor = HexColor.fromHex("292941");
  static final appBarIconColor = appBarTextColor;
  static final appBarTextStyle = TextStyle(color: appBarTextColor);

  static final primaryColor = HexColor.fromHex("EB7E44");
  static final bodyBackground = HexColor.fromHex("F7F7F9");

  /// text fields
  static const textDecoration = InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,

  );
  static final fieldBackground = Colors.white;
}

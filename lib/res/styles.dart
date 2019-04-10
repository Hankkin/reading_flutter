import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reading_flutter/res/dimens.dart';

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colors.black54,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.black54,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: Colors.black54,
  );
}

class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: Colors.grey)));
}
/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);
}
class RStyle {
  static TextStyle themeTxt = TextStyle(
    color: Color(0xff057FFF),
    fontSize: 15
  ); 
}
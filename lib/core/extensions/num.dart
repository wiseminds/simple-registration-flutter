import 'package:flutter/material.dart'; 

extension DoubleExt on double { 

  /// a spacer widget, this can be invoked by ending any double value with `.s`, 
  /// for instance ```.0.s```
  Spacer get s => const Spacer();

  /// convert a double field to SizedBox with its height, for instance `20.0.h` will give you a sized box with height of 20 pixels
   SizedBox get h => SizedBox(height: this);

  /// convert a double field to SizedBox with its widget, for instance `20.0.w` will give you a sized box with width of 20 pixels
  SizedBox get w => SizedBox(width: this);

  /// convert a double field to border radius with radius of its value
  BorderRadius get toBorderRadius => BorderRadius.circular(this);
}

extension IntExt on int {
  /// returns date in milliseconds as current Time + (this represented as seconds)
  int get secondsToMilliseconds =>
      DateTime.now().add(Duration(seconds: this)).millisecondsSinceEpoch;

  /// compares time in milliseconds against current timestamp
  /// and returns true if time is past
  bool get isPast => DateTime.now().millisecondsSinceEpoch > this;
  // double get height => ScreenUtil().setHeight(this);
}

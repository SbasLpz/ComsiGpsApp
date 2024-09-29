import 'package:flutter/material.dart';

class GlobalContext {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static var version = "Last version";
  //static var appBar = "RoadControl";
  static final ValueNotifier<String> appBar = ValueNotifier("RoadControl");
}
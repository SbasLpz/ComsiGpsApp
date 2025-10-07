import 'package:flutter/material.dart';

class GlobalContext {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static var version = "Last version";
  //static var appBar = "RoadControl";
  static final ValueNotifier<String> appBar = ValueNotifier("RoadControl");
  static var username = "";

  static Map<String, String> getLatLng(String coords) {
    var splitList = coords.split(",");

    var lat = splitList[0];
    var long = splitList[1];

    return {"lat": lat, "long": long};
  }
}
import 'package:flutter/cupertino.dart';

class NavigationManager extends ChangeNotifier{
  // ------- Instancia unica compartida - Singleton ------
  static final NavigationManager instancia = NavigationManager._internal();
  factory NavigationManager() {
    return instancia;
  }
  NavigationManager._internal();
  // ------- Instancia unica compartida - Singleton ------
  int currentPageIndexNavBar0 = 0;
  String username = "";

  setIndex(int inx){
    currentPageIndexNavBar0 = inx;
    notifyListeners();
  }

  setUserName(String user){
    username = user;
    notifyListeners();
  }

}
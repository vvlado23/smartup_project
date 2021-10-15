import 'package:flutter/material.dart';

import '../database/database_calls.dart';
import './item.dart';

class Menus extends ChangeNotifier {
  //constructor
  Menus(this.context) {
    setMenusList();
  }

  //vars
  BuildContext context;
  final List<String> _menusList = [];
  final List<String> _menusPathsList = [];

  Map<String, List<Item>> _menuAndItemsList = Map();

  Map<String, List<Item>> get menuAndItemsList {
    return {..._menuAndItemsList};
  }

  List<String> get menusList {
    return [..._menusList];
  }

  List<String> get menusPathsList {
    return [..._menusPathsList];
  }

  //stores menu names and paths from database to provider variables
  Future<void> setMenusList() async {
    for (int i = 1; i < 4; i++) {
      _menusList.add(await DatabaseCalls().getTitle(i));
      _menusPathsList.add(await DatabaseCalls().getContentKeyPaths(i));
    }

    notifyListeners();
    //await setItemsMap();
  }

  Future<void> setItemsMap(String path) async {
    if (_menuAndItemsList.containsKey(path)) {
      return;
    }
    _menuAndItemsList[path] = await DatabaseCalls().getItemMap(path);
    notifyListeners();
  }
}

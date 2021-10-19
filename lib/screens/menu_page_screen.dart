import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/food_listview_widget.dart';

import '../providers/menus.dart';

class MenuPageScreen extends StatelessWidget {
  final int menuNum;
  final String menuPath;

  const MenuPageScreen(
      {Key? key, required this.menuNum, required this.menuPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menusData = Provider.of<Menus>(context);
    final items = menusData.menuAndItemsList[menuPath];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Menu $menuNum',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          //backgroundColor: Colors.black45,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: items!.length,
          itemBuilder: (context, index) {
            return FoodListViewWidget(
              item: items[index],
              index: index,
              path: menuPath,
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/menus.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({Key? key, required this.path, required this.index})
      : super(key: key);

  final String path;
  final int index;

  @override
  Widget build(BuildContext context) {
    final menusData = Provider.of<Menus>(context);
    final Item item = menusData.menuAndItemsList[path]![index];
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
    );
  }
}

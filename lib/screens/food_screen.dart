import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/menus.dart';
import '../widgets/food_sliver_list.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Colors.black38),
              child: Text(
                item.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: item.itemKey,
                child: item.imageUrl != null
                    ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                    : Image.asset('./lib/images/logo.png'),
              ),
            ),
          ),
          FoodSliver(item: item),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Item extends ChangeNotifier {
  final String itemKey;
  final String? description;
  final String title;
  final String? imagePath;
  final String? imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final String? webUrl;
  final String? ytUrl;

  Item(
      {required this.itemKey,
      this.description,
      required this.title,
      this.imagePath,
      this.imageUrl,
      required this.ingredients,
      required this.instructions,
      this.webUrl,
      this.ytUrl});

  // Item.def({
  //   this.itemKey = " ",
  //   this.description = " ",
  //   this.title = " ",
  //   this.imagePath = " ",
  //   this.imageUrl = " ",
  //   this.ingredients = const [" "],
  //   this.instructions = const [" "],
  //   this.webUrl = " ",
  //   this.ytUrl = " ",
  // });
}

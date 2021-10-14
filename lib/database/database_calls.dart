import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../providers/item.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class DatabaseCalls {
  DatabaseCalls(this.context);
  BuildContext context;
  //Map<String, List<Item>> resultMap = {};

  Future<String> getTitle(int menuNumber) async {
    DatabaseReference _ref = database
        .reference()
        .child('menu_options/menu_option_$menuNumber/title');
    String result = await _ref.once().then((value) => value.value);
    return result;
  }

  Future<String> getContentKeyPaths(int menuNumber) async {
    DatabaseReference _ref = database
        .reference()
        .child('menu_options/menu_option_$menuNumber/contents_keys_path');
    var result = await _ref.once().then((value) => value.value);

    return result;
  }

  Future<List<Item>> getItemMap(String key) async {
    DatabaseReference _ref = database.reference().child('${key}');
    var dataResult = await _ref.once().then((value) => value.value);
    var resultMap = await getItems([...dataResult.keys].cast<String>());

    return resultMap;
  }

  Future<List<Item>> getItems(List<String> keys) async {
    List<Item> itemMap = [];
    for (String key in keys) {
      Item item = await getItemVars(key);

      itemMap.add(item);
    }
    return itemMap;
  }

  Future<Item> getItemVars(String key) async {
    Item item;
    //database calls
    //Item Summary:
    DatabaseReference _ref = database.reference().child('item_summaries/$key');
    var resultSummary = await _ref.once().then((value) => value.value);
    //Item Content:
    _ref = database.reference().child('item_contents/$key');
    var resultContent = await _ref.once().then((value) => value.value);
    //Website URL:
    _ref = database.reference().child('item_external_links/website_urls/$key');
    var resultweb = await _ref.once().then((value) => value.value);
    //YouTube URL:
    _ref = database.reference().child('item_external_links/youtube_urls/$key');
    var resultYt = await _ref.once().then((value) => value.value);

    item = Item(
        itemKey: key,
        title: resultSummary["title"],
        description: resultSummary["description"],
        imagePath: resultSummary["image_path"],
        ingredients: resultContent["ingredients"].cast<String>(),
        instructions: resultContent["instructions"].cast<String>(),
        webUrl: resultweb,
        ytUrl: resultYt);

    return item;
  }
}

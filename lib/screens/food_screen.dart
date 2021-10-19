import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/item.dart';
import '../providers/menus.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({Key? key, required this.path, required this.index})
      : super(key: key);

  final String path;
  final int index;

  Widget ingredientsList(List<String> items) {
    List<Text> _texts = [];

    for (String ing in items) {
      _texts.add(Text('\u2022 $ing'));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [..._texts]);
  }

  Widget instructionsList(List<String> items) {
    List<Row> _rows = [];

    for (int i = 0; i < items.length; i++) {
      _rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey,
            ),
            child: Text(
              '${i + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(child: Text(items[i])),
        ],
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [..._rows],
    );
  }

  void _launchURL(String myUrl) async {
    print(await canLaunch('https://www.google.com'));
    await launch(myUrl);
    //await canLaunch(myUrl) ? await launch(myUrl) : throw 'Could not launch URL';
  }

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
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item.title,
                  textScaleFactor: 1.5,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(item.webUrl);
                          _launchURL(item.ytUrl ?? " ");
                        },
                        child: const Image(
                          width: 70,
                          height: 70,
                          image: AssetImage('./lib/images/yt icon.png'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          _launchURL(item.webUrl!);
                        },
                        child: const Image(
                          width: 70,
                          height: 70,
                          image: AssetImage('./lib/images/web icon.png'),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          "Περιγραφή",
                          textScaleFactor: 1.3,
                        ),
                        const SizedBox(height: 5),
                        Text('${item.description}'),
                        const SizedBox(height: 5),
                        const Text(
                          'Υλικά',
                          textScaleFactor: 1.3,
                        ),
                        const SizedBox(height: 5),
                        ingredientsList(item.ingredients),
                        const SizedBox(height: 5),
                        const Text(
                          'Εκτέλεση',
                          textScaleFactor: 1.3,
                        ),
                        const SizedBox(height: 5),
                        instructionsList(item.instructions),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}

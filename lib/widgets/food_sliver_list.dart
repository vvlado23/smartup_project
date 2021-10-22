import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodSliver extends StatelessWidget {
  final item;
  const FoodSliver({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  siteButton(item.ytUrl, './lib/images/yt icon.png', context),
                  const SizedBox(height: 30),
                  siteButton(item.webUrl, './lib/images/web icon.png', context)
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    "Περιγραφή",
                    textScaleFactor: 1.3,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${item.description}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Υλικά',
                    textScaleFactor: 1.3,
                  ),
                  const SizedBox(height: 5),
                  ingredientsList(item.ingredients, context),
                  const SizedBox(height: 5),
                  const Text(
                    'Εκτέλεση',
                    textScaleFactor: 1.3,
                  ),
                  const SizedBox(height: 5),
                  instructionsList(item.instructions, context),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget siteButton(String? siteUrl, String imageUrl, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(siteUrl ?? ' ', context);
      },
      child: Image(
        width: 60,
        height: 60,
        image: AssetImage(imageUrl),
      ),
    );
  }

  Widget ingredientsList(List<String> items, BuildContext context) {
    List<Text> _texts = [];

    for (String ing in items) {
      _texts.add(Text(
        '\u2022 $ing',
        style: Theme.of(context).textTheme.bodyText1,
      ));
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [..._texts]);
  }

  Widget instructionsList(List<String> items, BuildContext context) {
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
          Expanded(
              child: Text(
            items[i],
            style: Theme.of(context).textTheme.bodyText1,
          )),
        ],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [..._rows],
    );
  }

  void _launchURL(String myUrl, BuildContext context) async {
    const SnackBar snack = SnackBar(
      content: Text('Page not found'),
      duration: Duration(seconds: 1),
    );
    if (await canLaunch(myUrl)) {
      await launch(myUrl);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }
}

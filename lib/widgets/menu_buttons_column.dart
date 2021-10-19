import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_project/providers/menus.dart';
import 'package:smartup_project/screens/menu_page_screen.dart';

class MenuButtonsColumn extends StatefulWidget {
  const MenuButtonsColumn({Key? key}) : super(key: key);

  @override
  _MenuButtonsColumnState createState() => _MenuButtonsColumnState();
}

class _MenuButtonsColumnState extends State<MenuButtonsColumn> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuButtons(context) // menuButtons(context),
            );
  }

  List<Widget> menuButtons(BuildContext context) {
    final menusData = Provider.of<Menus>(context);
    final menuPaths = menusData.menusPathsList;
    final menusName = menusData.menusList;

    List<Widget> buttons = [];

    for (int i = 0; i < menusName.length; i++) {
      buttons.add(Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black, width: 0.5))),
        child: TextButton(
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });
            await menusData
                .setItemsMap(menuPaths[i])
                .then((_) {})
                .then(
                  (_) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPageScreen(
                        menuNum: (i + 1),
                        menuPath: menuPaths[i],
                      ),
                    ),
                  ),
                )
                .then((value) => setState(() {
                      _isLoading = false;
                    }));
          },
          child: SizedBox(
            width: double.infinity,
            child: Text(
              menusName[i],
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ));
    }
    return buttons;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/login.dart';

import '../screens/home_page_screen.dart';
import '../screens/login_sceen.dart';

import '../providers/menus.dart';

class MenuOptionsScreen extends StatelessWidget {
  const MenuOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final menusData = Provider.of<Menus>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Login.out().doLogout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(50),
              child: const Image(
                image: AssetImage('./lib/images/logo.png'),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuButtons(context) // menuButtons(context),
                ),
          ],
        ),
      ),
    );
  }
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
          await menusData.setItemsMap(menuPaths[i]);
          //print(menuPaths[i]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageScreen(
                menuNum: (i + 1),
                menuPath: menuPaths[i],
              ),
            ),
          );
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

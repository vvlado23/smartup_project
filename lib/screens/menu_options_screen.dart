import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';

import '../screens/login_sceen.dart';

import '../widgets/menu_buttons_column.dart';

class MenuOptionsScreen extends StatelessWidget {
  MenuOptionsScreen({Key? key}) : super(key: key);

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
            const MenuButtonsColumn()
          ],
        ),
      ),
    );
  }
}

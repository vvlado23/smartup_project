import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartup_project/database/database_calls.dart';

import './screens/login_sceen.dart';
import './screens/menu_options_screen.dart';

import './auth/login.dart';

import './providers/menus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Menus(context),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.grey.shade600),
            textTheme:
                TextTheme(bodyText1: TextStyle(color: Colors.grey.shade600))),
        home: setFirstScreen(context),
      ),
    );
  }
}

Widget setFirstScreen(BuildContext context) {
  if (auth.currentUser?.uid != null) {
    return MenuOptionsScreen();
  } else {
    return const LoginScreen();
  }
}

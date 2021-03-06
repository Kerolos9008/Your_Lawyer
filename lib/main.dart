import 'package:Your_Lawyer/Pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/user.dart';
import 'Pages/splashScreen.dart';
import 'Services/userAuth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: UserAuthService().user,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.brown[400],
          accentColor: Colors.pink,
        ),
        home: SplashScreenPage(),
      ),
    );
  }
}

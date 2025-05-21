import 'package:accounting/module/auth/login_page.dart';
import 'package:accounting/module/menu/menu_page.dart';
import 'package:accounting/pref/pref.dart';
import 'package:flutter/material.dart';

class SplashScreenNotifier extends ChangeNotifier {
  final BuildContext context;

  SplashScreenNotifier({required this.context}) {
    getProfile();
  }

  getProfile() async {
    Future.delayed(Duration(seconds: 2)).then((e) {
      Pref().getUsers().then((value) {
        print(value.id);
        value.id != 0
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
                ((route) => false))
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                ((route) => false));
        notifyListeners();
      });
    });
  }
}

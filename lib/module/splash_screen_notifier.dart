import 'package:flutter/material.dart';

class SplashScreenNotifier extends ChangeNotifier {
  final BuildContext context;

  SplashScreenNotifier({required this.context}) {
    getProfile();
  }

  getProfile() async {}
}

import 'package:accounting/module/menu/menu_page.dart';
import 'package:accounting/utils/custom_scroll.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MenuPage(),
      scrollBehavior: MyCustomScrollBehavior(),
      title: "Accounting",
    );
  }
}

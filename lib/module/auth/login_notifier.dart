import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/module/menu/menu_page.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../network/network.dart';

class LoginNotifier extends ChangeNotifier {
  final BuildContext context;

  LoginNotifier({required this.context});

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var data = {
        "userid": username.text.trim(),
        "pass": password.text.trim(),
      };
      Setuprepository.setup(token, NetworkURL.auth(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          UserModel users = UserModel.fromJson(value);
          Pref().simpan(users);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
              (route) => false);
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }
}

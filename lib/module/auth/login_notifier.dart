import 'dart:convert';

import 'package:cif/models/index.dart';
import 'package:cif/module/menu/menu_page.dart';
import 'package:cif/pref/pref.dart';
import 'package:cif/repository/SetupRepository.dart';
import 'package:cif/utils/dialog_loading.dart';
import 'package:cif/utils/informationdialog.dart';
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
      Setuprepository.setup(token, NetworkURL.auth(), jsonEncode(data)).then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          UserModel users = UserModel.fromJson(value);
          Pref().simpan(users);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MenuPage()), (route) => false);
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }
}

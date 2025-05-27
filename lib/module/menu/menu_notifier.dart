import 'package:accounting/models/index.dart';
import 'package:accounting/module/auth/login_page.dart';
import 'package:accounting/pref/pref.dart';
import 'package:flutter/material.dart';

import '../../utils/button_custom.dart';

class MenuNotifier extends ChangeNotifier {
  final BuildContext context;

  MenuNotifier({required this.context}) {
    getProfile();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      notifyListeners();
    });
  }

  int page = 0;
  gantimenu(int value) {
    page = value;
    notifyListeners();
  }

  confirm() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin Keluar aplikasi?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ButtonSecondary(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        name: "Tidak",
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ButtonPrimary(
                        onTap: () {
                          Navigator.pop(context);
                          Pref().remove();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                        name: "Ya",
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';

class LevelUserNotifier extends ChangeNotifier {
  final BuildContext context;

  LevelUserNotifier({required this.context}) {
    getModul();
  }

  var dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  var editData = false;

  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      print(jsonEncode(listModulAdd));
    }
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  Set<String> selectedModuls = {}; // nama modul
  Set<String> selectedMenus = {}; // nama menu
  Set<String> selectedSubmenus = {}; // nama submenu

  void toggleModul(ModulModel modul, bool selected) {
    if (selected) {
      selectedModuls.add(modul.modul);
      for (var menu in modul.menu) {
        selectedMenus.add(menu.menu);
        for (var submenu in menu.submenu) {
          selectedSubmenus.add(submenu.submenu);
        }
      }
    } else {
      selectedModuls.remove(modul.modul);
      for (var menu in modul.menu) {
        selectedMenus.remove(menu.menu);
        for (var submenu in menu.submenu) {
          selectedSubmenus.remove(submenu.submenu);
        }
      }
    }
    notifyListeners();
  }

  void toggleMenu(
      ModulModel modul, ItemCategoryModulModel menu, bool selected) {
    if (selected) {
      selectedMenus.add(menu.menu);
      for (var submenu in menu.submenu) {
        selectedSubmenus.add(submenu.submenu);
      }
    } else {
      selectedMenus.remove(menu.menu);
      for (var submenu in menu.submenu) {
        selectedSubmenus.remove(submenu.submenu);
      }
    }

    // Cek apakah semua menu di modul terpilih
    bool allMenusSelected =
        modul.menu.every((m) => selectedMenus.contains(m.menu));
    if (allMenusSelected) {
      selectedModuls.add(modul.modul);
    } else {
      selectedModuls.remove(modul.modul);
    }

    notifyListeners();
  }

  void toggleSubmenu(ModulModel modul, ItemCategoryModulModel menu,
      ItemModulModel submenu, bool selected) {
    if (selected) {
      selectedSubmenus.add(submenu.submenu);
    } else {
      selectedSubmenus.remove(submenu.submenu);
    }

    // Cek apakah semua submenu di menu terpilih
    bool allSubmenusSelected =
        menu.submenu.every((s) => selectedSubmenus.contains(s.submenu));
    if (allSubmenusSelected) {
      selectedMenus.add(menu.menu);
    } else {
      selectedMenus.remove(menu.menu);
    }

    // Cek apakah semua menu di modul terpilih
    bool allMenusSelected =
        modul.menu.every((m) => selectedMenus.contains(m.menu));
    if (allMenusSelected) {
      selectedModuls.add(modul.modul);
    } else {
      selectedModuls.remove(modul.modul);
    }

    notifyListeners();
  }

  TextEditingController levelUsers = TextEditingController();
  var isLoading = true;
  List<ModulModel> listModul = [];
  List<ModulModel> listModulAdd = [];
  List<ItemCategoryModulModel> listMenuAdd = [];
  List<ItemModulModel> listSubmenu = [];
  pilihModul(ModulModel value) async {
    if (listModulAdd.isEmpty) {
      listModulAdd.add(value);
    } else {
      if (listModulAdd.where((e) => e == value).isNotEmpty) {
        listModulAdd.remove(value);
      } else {
        listModulAdd.add(value);
      }
    }

    notifyListeners();
  }

  Future getModul() async {
    isLoading = true;
    listModul.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getModul(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listModul.add(ModulModel.fromJson(i));
        }
        getLevelusers();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getLevelusers() async {
    isLoading = true;
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getLevelUsers(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}

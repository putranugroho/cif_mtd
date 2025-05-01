import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

class LevelUserNotifier extends ChangeNotifier {
  final BuildContext context;

  LevelUserNotifier({required this.context}) {
    getModul();
  }

  var dialog = false;
  tambah() {
    editModul = false;
    editData = false;
    dialog = true;
    notifyListeners();
  }

  var editData = false;

  var editModul = false;

  final keyForm = GlobalKey<FormState>();
  List<LevelUserModul> listTmp = [];
  List<bool> listView = [];
  List<bool> listinput = [];
  List<bool> listedit = [];
  List<bool> listdelete = [];
  ModulModel? modulModel;
  ItemCategoryModulModel? itemCategoryModulModel;
  List<MenuAccess> menuAccessList = [];

  void toggleMenu(int index, bool? value) {
    menuAccessList[index].isSelected = value ?? false;
    menuAccessList[index].view = value ?? false;
    menuAccessList[index].input = value ?? false;
    menuAccessList[index].edit = value ?? false;
    menuAccessList[index].delete = value ?? false;
    notifyListeners();
  }

  piliview(int index) {
    listView[index] = !listView[index];
    addModule(itemCategoryModulModel!.submenu[index], index);
    notifyListeners();
  }

  pilihinput(int index) {
    listinput[index] = !listinput[index];
    addModule(itemCategoryModulModel!.submenu[index], index);
    notifyListeners();
  }

  pilihedit(int index) {
    listedit[index] = !listedit[index];
    addModule(itemCategoryModulModel!.submenu[index], index);
    notifyListeners();
  }

  pilihdelete(int index) {
    listdelete[index] = !listdelete[index];
    addModule(itemCategoryModulModel!.submenu[index], index);
    notifyListeners();
  }

  Map<String, ItemCategoryModulModel> submenuToMenuMap = {};
  addModule(ItemModulModel value, int index) {
    var currentMenu = submenuToMenuMap[value.submenu];

    if (currentMenu == null) {
      print("Menu not found for submenu ${value.submenu}");
      return;
    }

    if (listTmp.isEmpty) {
      listTmp.add(LevelUserModul(
        modul: modulModel!.modul,
        menu: currentMenu.menu, // <- pakai dari mapping!
        submenu: value.submenu,
        view: listView[index] ? "Y" : "N",
        input: listinput[index] ? "Y" : "N",
        edit: listedit[index] ? "Y" : "N",
        delete: listdelete[index] ? "Y" : "N",
      ));
      print("Tambah");
    } else {
      if (listTmp
          .where((e) =>
              e.modul == modulModel!.modul &&
              e.menu == currentMenu.menu &&
              e.submenu == value.submenu)
          .isNotEmpty) {
        listTmp.removeWhere((e) =>
            e.modul == modulModel!.modul &&
            e.menu == currentMenu.menu &&
            e.submenu == value.submenu);
        print("Remove");
      } else {
        listTmp.add(LevelUserModul(
          modul: modulModel!.modul,
          menu: currentMenu.menu,
          submenu: value.submenu,
          view: listView[index] ? "Y" : "N",
          input: listinput[index] ? "Y" : "N",
          edit: listedit[index] ? "Y" : "N",
          delete: listdelete[index] ? "Y" : "N",
        ));
        print("Tambah");
      }
    }

    notifyListeners();
  }

  simpanModul() {
    print(menuAccessList);
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        // print(jsonEncode(listModulAdd));
        var data = {
          "id": levelUser!.idLevel,
          "kode_pt": "001",
          "level_user": "${levelUsers.text.trim()}",
        };
        Setuprepository.setup(
                token, NetworkURL.editLevelUsers(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getLevelusers();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        // print(jsonEncode(listModulAdd));
        var data = {
          "kode_pt": "001",
          "level_user": "${levelUsers.text.trim()}",
        };
        Setuprepository.setup(
                token, NetworkURL.addLevelUsers(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getLevelusers();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  clear() async {
    dialog = false;
    editData = false;
    editModul = false;
    levelUsers.clear();
    notifyListeners();
  }

  tutup() {
    dialog = false;
    editModul = false;
    editData = false;
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

  void togglePermission(int index, String permission, bool? value) {
    switch (permission) {
      case 'view':
        menuAccessList[index].view = value ?? false;
        break;
      case 'input':
        menuAccessList[index].input = value ?? false;
        break;
      case 'edit':
        menuAccessList[index].edit = value ?? false;
        break;
      case 'delete':
        menuAccessList[index].delete = value ?? false;
        break;
    }
    // jika semua permission di-uncheck, auto uncheck menu
    if (!menuAccessList[index].view &&
        !menuAccessList[index].input &&
        !menuAccessList[index].edit &&
        !menuAccessList[index].delete) {
      menuAccessList[index].isSelected = false;
    } else {
      menuAccessList[index].isSelected = true;
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
    modulModel = value;
    listView.clear();
    listinput.clear();
    listedit.clear();
    listdelete.clear();
    notifyListeners();
  }

  pilihMenu(ItemCategoryModulModel value) async {
    itemCategoryModulModel = value;
    listView.clear();
    listinput.clear();
    listedit.clear();
    listdelete.clear();
    menuAccessList.clear();
    notifyListeners();
    for (var i = 0; i < itemCategoryModulModel!.submenu.length; i++) {
      menuAccessList.add(MenuAccess(
          menuName: "${itemCategoryModulModel!.submenu[i].keterangan}"));
      listView.add(false);
      listinput.add(false);
      listedit.add(false);
      listdelete.add(false);
      // submenuToMenuMap[itemCategoryModulModel!.submenu[i].submenu] = value;
    }
    notifyListeners();
  }

  LevelUser? levelUser;

  editModuls(String id) {
    dialog = true;
    editData = false;
    editModul = true;
    levelUser = list.where((e) => e.idLevel == id).first;
    notifyListeners();
  }

  edit(String id) {
    dialog = true;
    editData = true;
    editModul = false;
    levelUser = list.where((e) => e.idLevel == id).first;
    levelUsers.text = levelUser!.levelUser;
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

  List<LevelUser> list = [];
  Future getLevelusers() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getLevelUsers(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(LevelUser.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}

class MenuAccess {
  String menuName;
  bool isSelected;
  bool view;
  bool input;
  bool edit;
  bool delete;

  MenuAccess({
    required this.menuName,
    this.isSelected = false,
    this.view = false,
    this.input = false,
    this.edit = false,
    this.delete = false,
  });
}

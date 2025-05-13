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
    clear();
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

  // void toggleMenu(int index, bool? value, String submenu, String menu) {
  //   menuAccessList[index].isSelected = value ?? false;
  //   menuAccessList[index].menu = menu;
  //   menuAccessList[index].modul = modulModel!.modul;
  //   menuAccessList[index].submenu = submenu;
  //   menuAccessList[index].view = value ?? false;
  //   menuAccessList[index].input = value ?? false;
  //   menuAccessList[index].edit = value ?? false;
  //   menuAccessList[index].delete = value ?? false;
  //   for (var i = 0; i < modulModel!.menu.length; i++) {
  //     String currentSubmenu = modulModel!.menu[i].submenu;
  //     String currentMenu = modulModel!.menu[i].menu;

  //     // cek apakah sudah ada di menuAccessList
  //     var indexExisting = menuAccessList.indexWhere(
  //       (e) =>
  //           e.modul == modulModel!.modul &&
  //           e.menu == currentMenu &&
  //           e.submenu == currentSubmenu,
  //     );

  //     if (indexExisting == -1) {
  //       // belum ada → tambahkan default
  //       menuAccessList.add(MenuAccess(
  //         modul: modulModel!.modul,
  //         menu: currentMenu,
  //         submenu: currentSubmenu,
  //       ));

  //       listView.add(false);
  //       listinput.add(false);
  //       listedit.add(false);
  //       listdelete.add(false);
  //     } else {
  //       // sudah ada → gunakan data yg sudah tersimpan
  //       var existing = menuAccessList[indexExisting];
  //       listView.add(existing.view);
  //       listinput.add(existing.input);
  //       listedit.add(existing.edit);
  //       listdelete.add(existing.delete);
  //     }
  //   }
  //   notifyListeners();
  // }

  void toggleMenu(int index, bool? value, String submenu, String menu) {
    final existingIndex = menuAccessList.indexWhere(
      (e) =>
          e.modul == modulModel!.modul &&
          e.menu == menu &&
          e.submenu == submenu,
    );

    if (existingIndex == -1) {
      // If the entry doesn't exist, add it
      menuAccessList.add(MenuAccess(
        modul: modulModel!.modul,
        menu: menu,
        submenu: submenu,
        isSelected: value ?? false,
        view: value ?? false,
        input: value ?? false,
        edit: value ?? false,
        delete: value ?? false,
      ));
    } else {
      final existing = menuAccessList[existingIndex];

      if (value == false) {
        // If checkbox is unchecked (value is false), remove the entry
        menuAccessList.removeAt(existingIndex);
      } else {
        // If checkbox is checked (value is true), update the permissions
        existing.isSelected = true;
        existing.view = value ?? false;
        existing.input = value ?? false;
        existing.edit = value ?? false;
        existing.delete = value ?? false;
      }
    }

    notifyListeners();
  }

  void togglePermissionBySubmenu(
    String modul,
    String menu,
    String submenu,
    String permissionType,
    bool? value,
  ) {
    final index = menuAccessList.indexWhere(
        (e) => e.modul == modul && e.menu == menu && e.submenu == submenu);

    if (index != -1) {
      switch (permissionType) {
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
    } else {
      // Belum ada datanya, tambahkan dulu
      menuAccessList.add(MenuAccess(
        modul: modul,
        menu: menu,
        submenu: submenu,
        view: permissionType == 'view' ? value ?? false : false,
        input: permissionType == 'input' ? value ?? false : false,
        edit: permissionType == 'edit' ? value ?? false : false,
        delete: permissionType == 'delete' ? value ?? false : false,
      ));
    }

    notifyListeners();
  }

  simpanModul() {
    // print(jsonEncode(menuAccessList));
    DialogCustom().showLoading(context);
    List<LevelUserModul> listtmp = [];
    for (var i = 0; i < menuAccessList.length; i++) {
      listtmp.add(LevelUserModul(
          modul: menuAccessList[i].modul,
          menu: menuAccessList[i].menu,
          submenu: menuAccessList[i].submenu,
          view: menuAccessList[i].view ? "Y" : "N",
          input: menuAccessList[i].input ? "Y" : "N",
          edit: menuAccessList[i].edit ? "Y" : "N",
          delete: menuAccessList[i].delete ? "Y" : "N"));
    }
    notifyListeners();
    var data = {"id": levelUser!.idLevel, "modul": listtmp};
    print(jsonEncode(data));
    Setuprepository.setup(
            token, NetworkURL.editLevelUsersModul(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getLevelusers();
        informationDialog(context, "Information", value['message']);
      } else {
        informationDialog(context, "Warning", value['message']);
        notifyListeners();
      }
    });
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
      }
    } else {
      selectedModuls.remove(modul.modul);
      for (var menu in modul.menu) {
        selectedMenus.remove(menu.menu);
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

  // void toggleSubmenu(ModulModel modul, ItemCategoryModulModel menu,
  //     ItemModulModel submenu, bool selected) {
  //   if (selected) {
  //     selectedSubmenus.add(submenu.submenu);
  //   } else {
  //     selectedSubmenus.remove(submenu.submenu);
  //   }

  //   // Cek apakah semua submenu di menu terpilih
  //   bool allSubmenusSelected =
  //       .every((s) => selectedSubmenus.contains(s));
  //   if (allSubmenusSelected) {
  //     selectedMenus.add(menu.menu);
  //   } else {
  //     selectedMenus.remove(menu.menu);
  //   }

  //   // Cek apakah semua menu di modul terpilih
  //   bool allMenusSelected =
  //       modul.menu.every((m) => selectedMenus.contains(m.menu));
  //   if (allMenusSelected) {
  //     selectedModuls.add(modul.modul);
  //   } else {
  //     selectedModuls.remove(modul.modul);
  //   }

  //   notifyListeners();
  // }

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

  // void togglePermissionBySubmenu(String modul, String menu, String submenu,
  //     String permission, bool? value) {
  //   var index = menuAccessList.indexWhere(
  //       (e) => e.modul == modul && e.menu == menu && e.submenu == submenu);

  //   if (index == -1) {
  //     // kalau belum ada, tambahkan default dulu
  //     menuAccessList.add(MenuAccess(
  //       modul: modul,
  //       menu: menu,
  //       submenu: submenu,
  //     ));
  //     index = menuAccessList.length - 1;
  //   }

  //   switch (permission) {
  //     case 'view':
  //       menuAccessList[index].view = value ?? false;
  //       break;
  //     case 'input':
  //       menuAccessList[index].input = value ?? false;
  //       break;
  //     case 'edit':
  //       menuAccessList[index].edit = value ?? false;
  //       break;
  //     case 'delete':
  //       menuAccessList[index].delete = value ?? false;
  //       break;
  //   }

  //   // auto update isSelected
  //   if (!menuAccessList[index].view &&
  //       !menuAccessList[index].input &&
  //       !menuAccessList[index].edit &&
  //       !menuAccessList[index].delete) {
  //     menuAccessList[index].isSelected = false;
  //   } else {
  //     menuAccessList[index].isSelected = true;
  //   }

  //   notifyListeners();
  // }

  // pilihMenu(ItemCategoryModulModel value) async {
  //   itemCategoryModulModel = value;
  //   listView.clear();
  //   listinput.clear();
  //   listedit.clear();
  //   listdelete.clear();
  //   // menuAccessList.clear();
  //   notifyListeners();

  //   for (var i = 0; i < itemCategoryModulModel!.submenu.length; i++) {
  //     String currentSubmenu = itemCategoryModulModel!.submenu[i].submenu;

  //     // cek apakah sudah ada di menuAccessList
  //     var indexExisting = menuAccessList.indexWhere(
  //       (e) =>
  //           e.modul == modulModel!.modul &&
  //           e.menu == itemCategoryModulModel!.menu &&
  //           e.submenu == currentSubmenu,
  //     );

  //     if (indexExisting == -1) {
  //       // belum ada → tambahkan default
  //       menuAccessList.add(MenuAccess(
  //         modul: modulModel!.modul,
  //         menu: itemCategoryModulModel!.menu,
  //         submenu: currentSubmenu,
  //       ));

  //       listView.add(false);
  //       listinput.add(false);
  //       listedit.add(false);
  //       listdelete.add(false);
  //     } else {
  //       // sudah ada → gunakan data yg sudah tersimpan
  //       var existing = menuAccessList[indexExisting];
  //       listView.add(existing.view);
  //       listinput.add(existing.input);
  //       listedit.add(existing.edit);
  //       listdelete.add(existing.delete);
  //     }
  //   }

  //   notifyListeners();
  // }

  // pilihMenu(ItemCategoryModulModel value) async {
  //   itemCategoryModulModel = value;
  //   listView.clear();
  //   listinput.clear();
  //   listedit.clear();
  //   listdelete.clear();
  //   notifyListeners();
  //   for (var i = 0; i < itemCategoryModulModel!.submenu.length; i++) {
  //     menuAccessList.add(MenuAccess(
  //       modul: modulModel!.modul,
  //       menu: itemCategoryModulModel!.menu,
  //       submenu: itemCategoryModulModel!.submenu[i].submenu,
  //     ));
  //     listView.add(false);
  //     listinput.add(false);
  //     listedit.add(false);
  //     listdelete.add(false);
  //     // submenuToMenuMap[itemCategoryModulModel!.submenu[i].submenu] = value;
  //   }
  //   notifyListeners();
  // }

  LevelUser? levelUser;

  editModuls(String id) {
    dialog = true;
    editData = false;
    editModul = true;
    levelUser = list.where((e) => e.idLevel == id).first;
    levelUsers.text = levelUser!.levelUser;
    menuAccessList.clear();

    // Isi ulang menuAccessList dari levelUser.moduls
    for (var m in levelUser!.moduls) {
      menuAccessList.add(MenuAccess(
        modul: m.modul,
        menu: m.menu,
        submenu: m.submenu,
        isSelected: true,
        view: m.view == "Y",
        input: m.input == "Y",
        edit: m.edit == "Y",
        delete: m.delete == "Y",
      ));
    }
    // for (var i = 0; i < levelUser!.moduls.length; i++) {
    //   menuAccessList.add(MenuAccess(
    //     modul: levelUser!.moduls[i].modul,
    //     menu: levelUser!.moduls[i].menu,
    //     submenu: levelUser!.moduls[i].submenu,
    //     isSelected: true,
    //     delete: levelUser!.moduls[i].delete == "Y" ? true : false,
    //     edit: levelUser!.moduls[i].edit == "Y" ? true : false,
    //     view: levelUser!.moduls[i].view == "Y" ? true : false,
    //     input: levelUser!.moduls[i].input == "Y" ? true : false,
    //   ));
    // }
    notifyListeners();
  }

  edit(String id) {
    dialog = true;
    editData = true;
    editModul = false;
    levelUser = list.where((e) => e.idLevel == id).first;

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
  String modul;
  String menu;
  String submenu;

  bool isSelected;
  bool view;
  bool input;
  bool edit;
  bool delete;

  MenuAccess({
    required this.modul,
    required this.menu,
    required this.submenu,
    this.isSelected = false,
    this.view = false,
    this.input = false,
    this.edit = false,
    this.delete = false,
  });
}

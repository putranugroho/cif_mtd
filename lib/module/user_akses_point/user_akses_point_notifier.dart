import 'dart:convert';

import 'package:accounting/models/users_model.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/akses_point_model.dart';
import '../../models/kantor_model.dart';
import '../../models/user_akses_point_model.dart';
import '../../network/network.dart';

class UserAksesPointNotifier extends ChangeNotifier {
  final BuildContext context;

  UserAksesPointNotifier({required this.context}) {
    getKantor();
    getAksesPoint();
  }

  edit(String id) {
    userAksesPointModel = listUsers.where((e) => e.id == int.parse(id)).first;
    notifyListeners();
  }

  List<AksesPointModel> listData = [];
  getAksesPoint() async {
    listData.clear();
    isLoading = true;
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAksesPoint(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(AksesPointModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  UserAksesPointModel? userAksesPointModel;
  var tambah = false;
  List<UserAksesPointModel> listUsers = [];
  getUsersAksesPoint() async {
    tambah = false;
    listUsers.clear();
    notifyListeners();
    DialogCustom().showLoading(context);
    var data = {
      "user_id": karyawanModel!.id,
      "kode_pt": karyawanModel!.kodePt,
    };
    // print(jsonEncode(data));
    Setuprepository.setup(
            token, NetworkURL.getUserAksesPoint(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'] == "NOT-FOUND") {
        notifyListeners();
      } else {
        for (Map<String, dynamic> i in value['akses_points']) {
          listUsers.add(UserAksesPointModel.fromJson(i));
        }
        tambah = true;
        notifyListeners();
      }
    });
  }

  AksesPointModel? aksesPointModel;
  List<AksesPointModel> listTmpAskes = [];
  addAkses(String id) {
    aksesPointModel = listData.where((e) => e.id == int.parse(id)).first;
    if (listTmpAskes.isEmpty) {
      listTmpAskes.add(aksesPointModel!);
    } else {
      if (listTmpAskes.where((e) => e == aksesPointModel).isNotEmpty) {
        listTmpAskes.remove(aksesPointModel!);
      } else {
        listTmpAskes.add(aksesPointModel!);
      }
    }
    notifyListeners();
  }

  simpanAkses() {
    if (listTmpAskes.isNotEmpty) {
      DialogCustom().showLoading(context);
      List<Map<String, dynamic>> listTmp = [];
      for (var i = 0; i < listTmpAskes.length; i++) {
        listTmp.add({
          "user_id": karyawanModel!.id,
          "emp_id": karyawanModel!.empId,
          "no_akses": listTmpAskes[i].noAkses,
          "akses_id": listTmpAskes[i].aksesId,
          "kode_pt": listTmpAskes[i].kodePt,
        });
      }
      notifyListeners();
      // print(jsonEncode(listTmp));
      Setuprepository.setup(
              token, NetworkURL.addUserAksesPoint(), jsonEncode(listTmp))
          .then((value) {
        Navigator.pop(context);
        getUsersAksesPoint();
        informationDialog(context, "Information", value['message']);
      });
    } else {
      informationDialog(context, "warning", "Pilih Akses Point Anda");
    }
  }

  List<KantorModel> list = [];
  var isLoading = true;
  Future getKantor() async {
    list.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          list.add(KantorModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  var search = false;
  KantorModel? kantor;

  List<UsersModel> listKaryawan = [];
  TextEditingController namaKaryawan = TextEditingController();
  TextEditingController nikKaryawan = TextEditingController();
  TextEditingController namaKantor = TextEditingController();
  UsersModel? karyawanModel;
  piliAkunKaryawan(UsersModel value) {
    karyawanModel = value;
    namaKaryawan.text = karyawanModel!.namauser;
    nikKaryawan.text = karyawanModel!.userid;
    print(karyawanModel!.kodeKantor);
    kantor = list.where((e) => e.kodeKantor == karyawanModel!.kodeKantor).first;
    namaKantor.text = kantor!.namaKantor;
    search = true;
    notifyListeners();
  }

  // var isLoadingUsers = false;

  // Future getUserAksesPoint() async {
  //   isLoadingUsers = true;
  //   listUsers.clear();
  //   search = true;
  //   notifyListeners();
  //   var data = {
  //     "user_id": karyawanModel!.id,
  //     "kode_pt": karyawanModel!.kodePt,
  //   };
  //   Setuprepository.setup(
  //           token, NetworkURL.getUserAksesPoint(), jsonEncode(data))
  //       .then((value) {
  //     if (value['status'] == "NOT-FOUND") {
  //       isLoadingUsers = false;
  //       notifyListeners();
  //     } else {
  //       for (Map<String, dynamic> i in value) {}
  //       isLoadingUsers = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  Future<List<UsersModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      listKaryawan.clear();
      notifyListeners();
      var data = {"namauser": query};
      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.cariUsers(),
          jsonEncode(data),
        );

        for (Map<String, dynamic> i in response) {
          listKaryawan.add(UsersModel.fromJson(i));
        }
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
      } finally {
        notifyListeners();
      }
    } else {
      listKaryawan.clear(); // clear on short query
    }

    return listKaryawan;
  }
}

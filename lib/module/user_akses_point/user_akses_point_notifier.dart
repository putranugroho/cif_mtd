import 'dart:convert';

import 'package:accounting/models/users_model.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/kantor_model.dart';
import '../../network/network.dart';

class UserAksesPointNotifier extends ChangeNotifier {
  final BuildContext context;

  UserAksesPointNotifier({required this.context}) {
    getKantor();
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

    notifyListeners();
  }

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

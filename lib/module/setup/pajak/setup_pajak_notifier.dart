import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/informationdialog.dart';

class SetupPajakNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupPajakNotifier({required this.context}) {
    getSetupPajak();
  }
  var isLoading = true;
  List<SetupPajakModel> list = [];
  SetupPajakModel? setupPajakModel;
  final keyForm = GlobalKey<FormState>();

  var editData = false;
  edit() {
    editData = !editData;
    getSetupPajak();
    notifyListeners();
  }

  var rincianData = false;
  rincian() {
    rincianData = !rincianData;
    notifyListeners();
  }

  bool akun = false;
  gantiakun(bool value) {
    akun = value;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var data = {
        "id": setupPajakModel!.id,
        "kode_pt": "001",
        "ppn1": "${ppn1.text.trim()}",
        "ppn2": "${ppn2.text.trim()}",
        "ppn3": "${ppn3.text.trim()}",
        "pph_23": "${pph23.text.trim()}",
        "maks_kena_ppn1": "${maksPpn1.text.trim().replaceAll(",", "")}",
        "maks_kena_ppn2": "${maksPpn2.text.trim().replaceAll(",", "")}",
        "maks_kena_ppn3": "${maksPpn3.text.trim().replaceAll(",", "")}",
      };
      Setuprepository.setup(
              token, NetworkURL.editSetupPajak(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          editData = !editData;
          informationDialog(context, "Information", value['message']);
          notifyListeners();
        } else {
          editData = !editData;
          informationDialog(context, "Warning", value['message'][0]);
          notifyListeners();
        }
      });
    }
  }

  Future getSetupPajak() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getSetupPajak(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(SetupPajakModel.fromJson(i));
        }
        setupPajakModel = list[0];
        ppn1.text = setupPajakModel!.ppn.contains(".")
            ? "${setupPajakModel!.ppn}"
            : "${setupPajakModel!.ppn}.00";
        ppn2.text = setupPajakModel!.ppn.contains(".")
            ? "${setupPajakModel!.ppn}"
            : "${setupPajakModel!.ppn}.00";
        ppn3.text = setupPajakModel!.ppn.contains(".")
            ? "${setupPajakModel!.ppn}"
            : "${setupPajakModel!.ppn}.00";
        pph23.text = setupPajakModel!.pph23.contains(".")
            ? "${setupPajakModel!.pph23}"
            : "${setupPajakModel!.pph23}.00";
        maksPpn1.text = FormatCurrency.oCcy
            .format(int.parse(setupPajakModel!.maksKenaPpn))
            .replaceAll(".", ",");
        maksPpn2.text = FormatCurrency.oCcy
            .format(int.parse(setupPajakModel!.maksKenaPpn))
            .replaceAll(".", ",");
        maksPpn3.text = FormatCurrency.oCcy
            .format(int.parse(setupPajakModel!.maksKenaPpn))
            .replaceAll(".", ",");
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  TextEditingController ppn1 = TextEditingController();
  TextEditingController maksPpn1 = TextEditingController();
  TextEditingController ppn2 = TextEditingController();
  TextEditingController maksPpn2 = TextEditingController();
  TextEditingController ppn3 = TextEditingController();
  TextEditingController maksPpn3 = TextEditingController();
  TextEditingController pph23 = TextEditingController();
}

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

  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var data = {
        "id": setupPajakModel!.id,
        "kode_pt": "001",
        "ppn": "${ppn.text.trim()}",
        "pph_23": "${pph23.text.trim()}",
        "maks_kena_ppn": "${maksPpn.text.trim().replaceAll(",", "")}",
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
        ppn.text = setupPajakModel!.ppn.contains(".")
            ? "${setupPajakModel!.ppn}"
            : "${setupPajakModel!.ppn}.00";
        pph23.text = setupPajakModel!.pph23.contains(".")
            ? "${setupPajakModel!.pph23}"
            : "${setupPajakModel!.pph23}.00";
        maksPpn.text = FormatCurrency.oCcy
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

  TextEditingController ppn = TextEditingController();
  TextEditingController maksPpn = TextEditingController();
  TextEditingController pph23 = TextEditingController();
}

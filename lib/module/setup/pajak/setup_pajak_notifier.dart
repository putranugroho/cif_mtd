import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';
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
  edit(String id) {
    editData = true;
    dialog = true;
    setupPajakModel = list.where((e) => e.id == int.parse(id)).first;
    ppn.text = setupPajakModel!.ppn;
    pph23.text = setupPajakModel!.pph23;
    maksPpn.text = setupPajakModel!.maksKenaPpn;
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
                    "Anda yakin menghapus ${setupPajakModel!.ppn}?",
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
                          remove();
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

  remove() {
    DialogCustom().showLoading(context);
    var data = {
      "id": setupPajakModel!.id,
    };
    Setuprepository.setup(
            token, NetworkURL.deleteSetupPajak(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getSetupPajak();
        clear();
        dialog = false;
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
  }

  var dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    clear();
    notifyListeners();
  }

  clear() {
    ppn.clear();
    maksPpn.clear();
    pph23.clear();
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

  var tipepajak = false;
  gantitipe() {
    tipepajak = !tipepajak;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      if (editData) {
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
            getSetupPajak();
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            editData = !editData;
            informationDialog(context, "Warning", value['message'][0]);
            notifyListeners();
          }
        });
      } else {
        var data = {
          "kode_pt": "001",
          "ppn": "${ppn.text.trim()}",
          "pph_23": "${pph23.text.trim()}",
          "maks_kena_ppn": "${maksPpn.text.trim().replaceAll(",", "")}",
        };
        Setuprepository.setup(
                token, NetworkURL.addSetupPajak(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getSetupPajak();
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
            notifyListeners();
          }
        });
      }
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
        // setupPajakModel = list[0];
        // ppn1.text = setupPajakModel!.ppn.contains(".")
        //     ? "${setupPajakModel!.ppn}"
        //     : "${setupPajakModel!.ppn}.00";
        // ppn2.text = setupPajakModel!.ppn.contains(".")
        //     ? "${setupPajakModel!.ppn}"
        //     : "${setupPajakModel!.ppn}.00";
        // ppn3.text = setupPajakModel!.ppn.contains(".")
        //     ? "${setupPajakModel!.ppn}"
        //     : "${setupPajakModel!.ppn}.00";
        // pph23.text = setupPajakModel!.pph23.contains(".")
        //     ? "${setupPajakModel!.pph23}"
        //     : "${setupPajakModel!.pph23}.00";
        // maksPpn1.text = FormatCurrency.oCcy
        //     .format(int.parse(setupPajakModel!.maksKenaPpn))
        //     .replaceAll(".", ",");
        // maksPpn2.text = FormatCurrency.oCcy
        //     .format(int.parse(setupPajakModel!.maksKenaPpn))
        //     .replaceAll(".", ",");
        // maksPpn3.text = FormatCurrency.oCcy
        //     .format(int.parse(setupPajakModel!.maksKenaPpn))
        //     .replaceAll(".", ",");
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

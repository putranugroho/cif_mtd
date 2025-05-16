import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../network/network.dart';
import '../../utils/colors.dart';
import '../../utils/informationdialog.dart';

class SetupClosingEomNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupClosingEomNotifier({required this.context}) {
    getClosingEom();
  }

  List<ClosingEomSetupModel> list = [];
  ClosingEomSetupModel? closingEomSetupModel;
  var isLoading = true;
  Future getClosingEom() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getClosingEom(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(ClosingEomSetupModel.fromJson(i));
        }
        if (list.isNotEmpty) {
          closingEomSetupModel = list.first;
          DateTime futureDate =
              getDateMonthsAgo(int.parse(closingEomSetupModel!.bulan));
          closingDate.text = DateFormat('MMMM').format(futureDate);
          backdatemundur.text = closingEomSetupModel!.bulan;
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  DateTime getDateMonthsAgo(int monthsAgo) {
    final now = DateTime.now();
    return DateTime(now.year, now.month - monthsAgo);
  }

  TextEditingController closing = TextEditingController(text: "3");
  TextEditingController backdatemundur = TextEditingController();
  TextEditingController closingDate = TextEditingController();

  int monthDifference(DateTime from, DateTime to) {
    return (to.year - (from.year - 1)) * 12 + to.month - from.month;
  }

  DateTime now = DateTime.now();
  showDate() async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                width: 500,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Pilih Periode",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 100,
                      child: ScrollDatePicker(
                          maximumDate: DateTime(int.parse(
                                  DateFormat('y').format(DateTime.now())) +
                              1),
                          options:
                              DatePickerOptions(backgroundColor: Colors.white),
                          viewType: [
                            DatePickerViewType.month,
                          ],
                          selectedDate: now,
                          onDateTimeChanged: (e) {
                            setState(() {
                              now = e;
                              closingDate.text = DateFormat('MMMM').format(now);
                              notifyListeners();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        final int selisihBulan =
                            monthDifference(now, DateTime.now());
                        print('Bulan ke belakang: $selisihBulan bulan');
                        backdatemundur.text = selisihBulan.toString();
                        notifyListeners();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Simpan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      if (closingEomSetupModel == null) {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "bulan": "${backdatemundur.text}",
        };
        Setuprepository.setup(
                token, NetworkURL.addClosingEom(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getClosingEom();
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "id": closingEomSetupModel == null ? null : closingEomSetupModel!.id,
          "kode_pt": "001",
          "bulan": "${backdatemundur.text}",
        };
        Setuprepository.setup(
                token, NetworkURL.editClosingEom(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getClosingEom();
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  bool jenisTrans = true;
  pilihJenisTransaksi(bool value) {
    jenisTrans = value;
    notifyListeners();
  }
}

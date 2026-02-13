import 'dart:convert';

import 'package:cif/repository/SetupRepository.dart';
import 'package:cif/utils/dialog_loading.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/index.dart';
import '../../../network/network.dart';
import '../../../utils/button_custom.dart';
import '../../../utils/informationdialog.dart';

class PiutangNotifier extends ChangeNotifier {
  final BuildContext context;

  PiutangNotifier({required this.context}) {
    getCustomers();
    getInqueryAll();
    notifyListeners();
  }

  Future getInqueryAll() async {
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems = extractJnsAccB(value['data']);
        listGl = jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  var isLoadingInquery = false;
  List<InqueryGlModel> listGl = [];
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();
  Future<List<InqueryGlModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();
      var data = {"kode_pt": "001"};
      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems = extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) => model.nosbb.toLowerCase().contains(query.toLowerCase()) || model.namaSbb.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  InqueryGlModel? inqueryGlModel;
  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModel = value;
    namasbb.text = value.namaSbb;
    nosbb.text = value.nosbb;
    notifyListeners();
  }

  int selisih = 0;

  Future pilihJthTempo(int index) async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      // tglTransaksi = pickedendDate;
      listTglJatuhTempo[index].text = DateFormat("y-MM-dd").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  changeCalculate() async {
    var tempobayar = listNominal.map((e) => int.parse(e.text.replaceAll(",", ""))).reduce((a, b) => a + b);
    selisih = int.parse(nilaiInvoice.text.replaceAll(",", "")) - tempobayar;
    notifyListeners();
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];
    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C') {
            result.add(item);
          }
          if (item.containsKey('items') && item['items'] is List) {
            traverse(item['items']);
          }
        }
      }
    }

    traverse(rawData);
    return result;
  }

  List<CustomerSupplierModel> listCustomer = [];
  getCustomers() async {
    isLoading = true;
    list.clear();
    listCustomer.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getCustomer(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listCustomer.add(CustomerSupplierModel.fromJson(i));
        }
        getHutangPiutang();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  DateTime? tglTransaksi;
  Future pilihTanggalInvoice() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) - 1,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      tglTransaksi = pickedendDate;
      tglInvoice.text = DateFormat("y-MM-dd").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  Future pilihTanggalJatuhTempo() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) - 1,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      tglJtTempo.text = DateFormat("y-MM-dd").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  var isLoading = true;
  List<PiutangHutangModel> list = [];
  Future getHutangPiutang() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001", "jns_invoice": "2"};
    Setuprepository.setup(token, NetworkURL.getHutangPiutang(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(PiutangHutangModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  var dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  TextEditingController noInvoice = TextEditingController();
  TextEditingController noSif = TextEditingController();
  TextEditingController nmSif = TextEditingController();
  TextEditingController tglInvoice = TextEditingController();
  TextEditingController nilaiInvoice = TextEditingController();
  TextEditingController ppn = TextEditingController(text: "0");
  TextEditingController pph = TextEditingController(text: "0");
  TextEditingController tglJtTempo = TextEditingController();
  TextEditingController bertahap = TextEditingController();
  TextEditingController jumlahTahap = TextEditingController();
  TextEditingController tglBayar = TextEditingController();
  TextEditingController nilaiBayar = TextEditingController();
  TextEditingController statusInvoice = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController nosbb = TextEditingController();
  TextEditingController namasbb = TextEditingController();

  final keyForm = GlobalKey<FormState>();
  PiutangHutangModel? piutangHutangModel;
  var editData = false;

  edit(String id) {
    dialog = true;
    editData = true;
    piutangHutangModel = list.where((e) => e.id == int.parse(id)).first;
    customerSupplierModel = listCustomer.where((e) => e.noSif == piutangHutangModel!.noSif).first;
    noInvoice.text = piutangHutangModel!.noInvoice;
    noSif.text = piutangHutangModel!.noSif;
    nmSif.text = piutangHutangModel!.nmSif;
    tglInvoice.text = piutangHutangModel!.tglInvoice;
    nilaiInvoice.text = FormatCurrency.oCcy.format(int.parse(piutangHutangModel!.nilaiInvoice)).replaceAll(".", ",");
    ppn.text = FormatCurrency.oCcy.format(int.parse(piutangHutangModel!.ppn)).replaceAll(".", ",");
    pph.text = FormatCurrency.oCcy.format(int.parse(piutangHutangModel!.pph)).replaceAll(".", ",");
    tglJtTempo.text = piutangHutangModel!.tglJtTempo;
    bertahap.text = piutangHutangModel!.bertahap;
    jumlahTahap.text = piutangHutangModel!.jumlahTahap;
    tglBayar.text = piutangHutangModel!.tglBayar;
    nilaiBayar.text = piutangHutangModel!.nilaiBayar;
    statusInvoice.text = piutangHutangModel!.statusInvoice;
    keterangan.text = piutangHutangModel!.keterangan;
    nosbb.text = piutangHutangModel!.noSbb;
    namasbb.text = piutangHutangModel!.namaSbb;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": piutangHutangModel!.id,
          "no_invoice": noInvoice.text,
          "jns_invoice": "2",
          "no_sif": customerSupplierModel!.noSif,
          "nm_sif": customerSupplierModel!.nmSif,
          "tgl_invoice": tglInvoice.text,
          "nilai_invoice": nilaiInvoice.text.replaceAll(",", ""),
          "ppn": ppn.text,
          "pph": pph.text,
          "tgl_jt_tempo": tglJtTempo.text,
          "bertahap": jenis ? "Y" : "N",
          "jumlah_tahap": jumlahTahap.text,
          "tgl_bayar": "",
          "nilai_bayar": "",
          "status_invoice": "A",
          "keterangan": keterangan.text,
          "no_sbb": nosbb.text,
          "nama_sbb": namasbb.text,
          "kode_pt": "001",
          "kode_kantor": "",
          "kode_induk": "",
          "kode_ao": customerSupplierModel!.kodeAoCustomer,
        };
        Setuprepository.setup(token, NetworkURL.editHutangPiutang(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getHutangPiutang();
            clear();
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "no_invoice": noInvoice.text,
          "jns_invoice": "2",
          "no_sif": customerSupplierModel!.noSif,
          "nm_sif": customerSupplierModel!.nmSif,
          "tgl_invoice": tglInvoice.text,
          "nilai_invoice": nilaiInvoice.text.replaceAll(",", ""),
          "ppn": ppn.text,
          "pph": pph.text,
          "tgl_jt_tempo": tglJtTempo.text,
          "bertahap": jenis ? "Y" : "N",
          "jumlah_tahap": jumlahTahap.text,
          "tgl_bayar": "",
          "nilai_bayar": "",
          "status_invoice": "A",
          "keterangan": keterangan.text,
          "no_sbb": nosbb.text,
          "nama_sbb": namasbb.text,
          "kode_pt": "001",
          "kode_kantor": "",
          "kode_induk": "",
          "kode_ao": customerSupplierModel!.kodeAoCustomer,
        };
        Setuprepository.setup(token, NetworkURL.addHutangPiutang(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getHutangPiutang();
            clear();
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      }
    }
  }

  confirm() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin menghapus ${piutangHutangModel!.noInvoice}?",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
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
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ButtonPrimary(
                        onTap: () {
                          Navigator.pop(context);
                          removes();
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

  removes() {
    DialogCustom().showLoading(context);
    var data = {
      "id": piutangHutangModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deleteHutangPiutang(), jsonEncode(data)).then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getHutangPiutang();
        clear();

        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }

  clear() {
    noInvoice.clear();
    customerSupplierModel = null;
    tglInvoice.clear();
    nilaiInvoice.clear();
    ppn.clear();
    pph.clear();
    tglJtTempo.clear();
    bertahap.clear();
    jumlahTahap.clear();
    tglBayar.clear();
    nilaiBayar.clear();
    statusInvoice.clear();
    keterangan.clear();
    nosbb.clear();
    namasbb.clear();
    dialog = false;
    editData = false;
    notifyListeners();
  }

  tutup() {
    clear();
    dialog = false;
    notifyListeners();
  }

  List<TextEditingController> listTglJatuhTempo = [];
  List<TextEditingController> listNominal = [];
  addJatuhTempo() {
    listTglJatuhTempo.add(TextEditingController());
    listNominal.add(TextEditingController());
    notifyListeners();
  }

  var jenis = false;
  gantijenis() {
    jenis = !jenis;
    notifyListeners();
  }

  remove(int index) {
    listTglJatuhTempo.removeAt(index);
    listNominal.removeAt(index);
    notifyListeners();
  }

  CustomerSupplierModel? customerSupplierModel;
  pilihCustomer(CustomerSupplierModel value) {
    customerSupplierModel = value;
    notifyListeners();
  }

  List<SetupTransModel> listData = [];
  SetupTransModel? setupTransModel;
  pilihSetupTransaksi(SetupTransModel value) {
    setupTransModel = value;
    notifyListeners();
  }
}

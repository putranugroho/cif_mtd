import 'package:flutter/cupertino.dart';

class PembayaranHutangNotifier extends ChangeNotifier {
  final BuildContext context;

  PembayaranHutangNotifier({required this.context}) {}

  var isLoading = false;
  final keyForm = GlobalKey<FormState>();

  int transaksi = 1;

  List<TextEditingController> listAmount = [];

  tambahTransaksi() {
    transaksi++;
    listAmount.add(TextEditingController(text: "0"));
    notifyListeners();
  }

  bool akun = false;
  gantiakun(bool value) {
    akun = value;
    notifyListeners();
  }

  bool kelebihan = false;
  gantikelebihan() {
    kelebihan = !kelebihan;
    notifyListeners();
  }

  var editData = false;
  edit() {
    editData = !editData;
    notifyListeners();
  }

  var rincianData = false;
  rincian() {
    rincianData = !rincianData;
    notifyListeners();
  }

  cek() {}

  TextEditingController ppn = TextEditingController();
  TextEditingController maksPpn = TextEditingController();
  TextEditingController pph23 = TextEditingController();
}

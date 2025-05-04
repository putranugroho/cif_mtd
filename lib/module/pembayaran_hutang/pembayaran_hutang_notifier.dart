import 'package:flutter/cupertino.dart';

class PembayaranHutangNotifier extends ChangeNotifier {
  final BuildContext context;

  PembayaranHutangNotifier({required this.context}) {}

  var isLoading = false;
  final keyForm = GlobalKey<FormState>();

  bool akun = false;
  gantiakun(bool value) {
    akun = value;
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

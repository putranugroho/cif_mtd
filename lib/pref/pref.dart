import 'package:accounting/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static String id = "id";
  static String userid = "userid";
  static String empId = "emp_id";
  static String pass = "pass";
  static String namauser = "namauser";
  static String batch = "batch";
  static String kodePt = "kode_pt";
  static String kodeKantor = "kode_kantor";
  static String kodeInduk = "kode_induk";
  static String tglexp = "tglexp";
  static String lvluser = "lvluser";
  static String terminalId = "terminal_id";
  static String aktivasi = "aktivasi";
  static String aksesKasir = "akses_kasir";
  static String sbbKasir = "sbb_kasir";
  static String namaSbb = "nama_sbb";
  static String fhoto1 = "fhoto_1";
  static String fhoto2 = "fhoto_2";
  static String fhoto3 = "fhoto_3";
  static String levelOtor = "level_otor";
  static String bedaKantor = "beda_kantor";
  static String minOtor = "min_otor";
  static String maxOtor = "max_otor";
  static String createddate = "createddate";
  static String isDeleted = "is_deleted";
  static String backDate = "back_date";

  simpan(UserModel users) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(Pref.id, users.id);
    pref.setString(Pref.userid, users.userid);
    pref.setString(Pref.empId, users.empId);
    pref.setString(Pref.pass, users.pass);
    pref.setString(Pref.namauser, users.namauser);
    pref.setString(Pref.batch, users.batch);
    pref.setString(Pref.kodePt, users.kodePt);
    pref.setString(Pref.kodeKantor, users.kodeKantor);
    pref.setString(Pref.kodeInduk, users.kodeInduk);
    pref.setString(Pref.tglexp, users.tglexp);
    pref.setString(Pref.lvluser, users.lvluser);
    pref.setString(Pref.terminalId, users.terminalId);
    pref.setString(Pref.aktivasi, users.aktivasi);
    pref.setString(Pref.aksesKasir, users.aksesKasir);
    pref.setString(Pref.sbbKasir, users.sbbKasir);
    pref.setString(Pref.namaSbb, users.namaSbb);
    pref.setString(Pref.fhoto1, users.fhoto1);
    pref.setString(Pref.fhoto2, users.fhoto2);
    pref.setString(Pref.fhoto3, users.fhoto3);
    pref.setString(Pref.levelOtor, users.levelOtor);
    pref.setString(Pref.bedaKantor, users.bedaKantor);
    pref.setString(Pref.minOtor, users.minOtor);
    pref.setString(Pref.maxOtor, users.maxOtor);
    pref.setString(Pref.createddate, users.createddate);
    pref.setString(Pref.isDeleted, users.isDeleted);
    pref.setString(Pref.backDate, users.backDate);
  }

  remove() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(Pref.id);
    pref.remove(Pref.userid);
    pref.remove(Pref.empId);
    pref.remove(Pref.pass);
    pref.remove(Pref.namauser);
    pref.remove(Pref.batch);
    pref.remove(Pref.kodePt);
    pref.remove(Pref.kodeKantor);
    pref.remove(Pref.kodeInduk);
    pref.remove(Pref.tglexp);
    pref.remove(Pref.lvluser);
    pref.remove(Pref.terminalId);
    pref.remove(Pref.aktivasi);
    pref.remove(Pref.aksesKasir);
    pref.remove(Pref.sbbKasir);
    pref.remove(Pref.namaSbb);
    pref.remove(Pref.fhoto1);
    pref.remove(Pref.fhoto2);
    pref.remove(Pref.fhoto3);
    pref.remove(Pref.levelOtor);
    pref.remove(Pref.bedaKantor);
    pref.remove(Pref.minOtor);
    pref.remove(Pref.maxOtor);
    pref.remove(Pref.createddate);
    pref.remove(Pref.isDeleted);
    pref.remove(Pref.backDate);
  }

  Future<UserModel> getUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserModel users = UserModel(
      id: pref.getInt(Pref.id) ?? 0,
      userid: pref.getString(Pref.userid) ?? "",
      empId: pref.getString(Pref.empId) ?? "",
      pass: pref.getString(Pref.pass) ?? "",
      namauser: pref.getString(Pref.namauser) ?? "",
      batch: pref.getString(Pref.batch) ?? "",
      kodePt: pref.getString(Pref.kodePt) ?? "",
      kodeKantor: pref.getString(Pref.kodeKantor) ?? "",
      kodeInduk: pref.getString(Pref.kodeInduk) ?? "",
      tglexp: pref.getString(Pref.tglexp) ?? "",
      lvluser: pref.getString(Pref.lvluser) ?? "",
      terminalId: pref.getString(Pref.terminalId) ?? "",
      aktivasi: pref.getString(Pref.aktivasi) ?? "",
      aksesKasir: pref.getString(Pref.aksesKasir) ?? "",
      sbbKasir: pref.getString(Pref.sbbKasir) ?? "",
      namaSbb: pref.getString(Pref.namaSbb) ?? "",
      fhoto1: pref.getString(Pref.fhoto1) ?? "",
      fhoto2: pref.getString(Pref.fhoto2) ?? "",
      fhoto3: pref.getString(Pref.fhoto3) ?? "",
      levelOtor: pref.getString(Pref.levelOtor) ?? "",
      bedaKantor: pref.getString(Pref.bedaKantor) ?? "",
      minOtor: pref.getString(Pref.minOtor) ?? "",
      maxOtor: pref.getString(Pref.maxOtor) ?? "",
      createddate: pref.getString(Pref.createddate) ?? "",
      isDeleted: pref.getString(Pref.isDeleted) ?? "",
      backDate: pref.getString(Pref.backDate) ?? "",
    );
    return users;
  }
}

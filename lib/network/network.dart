const token = "715f8ab555438f985b579844ea227767";
const xusername = "core@2023";
const xpassword = "corevalue@20231234";

const dev = false;

const url = dev ? "https://geacct.medtrans.id" : "https://geacct.medtrans.id";

const url2 = "https://core.metimes.id";

class NetworkURL {
  static String login() {
    return "$url/sign-in";
  }

  static String gerPerusahaan() {
    return "$url/perusahaan";
  }

  static String getKantor() {
    return "$url/kantor";
  }

  static String addKantor() {
    return "$url/kantor/add";
  }

  static String updateKantor() {
    return "$url/kantor/updated";
  }

  static String deletedKantor() {
    return "$url/kantor/deleted";
  }

  static String getLevelJabatan() {
    return "$url/leveljabatan";
  }

  static String addLevelJabatan() {
    return "$url/leveljabatan/add";
  }

  static String updateLevelJabatan() {
    return "$url/leveljabatan/update";
  }

  static String deletedLevelJabatan() {
    return "$url/leveljabatan/deleted";
  }

  static String getjabatan() {
    return "$url/jabatan";
  }

  static String addJabatan() {
    return "$url/jabatan/add";
  }

  static String updatedJabatan() {
    return "$url/jabatan/update";
  }

  static String deletedJabatan() {
    return "$url/jabatan/deleted";
  }

  static String getPejabat() {
    return "$url/pejabat";
  }

  static String addPejabat() {
    return "$url/pejabat/add";
  }

  static String updatedPejabat() {
    return "$url/pejabat/update";
  }

  static String deletedPejabat() {
    return "$url/pejabat/deleted";
  }

  static String getMasterGl() {
    return "$url/mastergl";
  }

  static String addMasterGl() {
    return "$url/mastergl/add";
  }

  static String editMasterGl() {
    return "$url/mastergl/update";
  }

  static String deleteMasterGl() {
    return "$url/mastergl/deleted";
  }

  static String getMetodePenyusutan() {
    return "$url/metode_penyusutan";
  }

  static String editMetodePenyusutan() {
    return "$url/metode_penyusutan/update";
  }

  static String getKelompokAset() {
    return "$url/kelompokaset";
  }

  static String addKelompokAset() {
    return "$url/kelompokaset/add";
  }

  static String editKelompokAset() {
    return "$url/kelompokaset/update";
  }

  static String deleteKelompokAset() {
    return "$url/kelompokaset/deleted";
  }

  static String getGolonganAset() {
    return "$url/golonganaset";
  }

  static String addGolonganAset() {
    return "$url/golonganaset/add";
  }

  static String editGolonganAset() {
    return "$url/golonganaset/update";
  }

  static String deleteGolonganAset() {
    return "$url/golonganaset/deleted";
  }

  static String getGolonganSbb() {
    return "$url/golongansbb";
  }

  static String addGolonganSbb() {
    return "$url/golongansbb/add";
  }

  static String editGolonganSbb() {
    return "$url/golongansbb/update";
  }

  static String deleteGolonganSbb() {
    return "$url/golongansbb/deleted";
  }

  static String getInqueryGL() {
    return "$url/mastergl/inquery";
  }

  static String getSbbKhusus() {
    return "$url/sbbkhusus";
  }

  static String addSbbKhusus() {
    return "$url/sbbkhusus/add";
  }

  static String editSbbKhusus() {
    return "$url/sbbkhusus/update";
  }

  static String deleteSbbKhusus() {
    return "$url/sbbkhusus/deleted";
  }

  static String getSetupTrans() {
    return "$url/setuptrans";
  }

  static String getSetupPajak() {
    return "$url/setuppajak";
  }

  static String editSetupPajak() {
    return "$url/setuppajak/update";
  }

  static String addSetupTrans() {
    return "$url/setuptrans/add";
  }

  static String editSetupTrans() {
    return "$url/setuptrans/update";
  }

  static String deleteSetupTrans() {
    return "$url/setuptrans/deleted";
  }

  static String getusers() {
    return "$url/users";
  }

  static String addusers() {
    return "$url/users/add";
  }

  static String editusers() {
    return "$url/users/update";
  }

  static String deleteusers() {
    return "$url/users/deleted";
  }

  static String getProvinsi() {
    return "$url2/provinsi";
  }

  static String getKota(String id) {
    return "$url2/kota?id=$id";
  }

  static String getKecamatan(String id) {
    return "$url2/kecamatan?id=$id";
  }

  static String getKelurahan(String id) {
    return "$url2/kelurahan?id=$id";
  }
}

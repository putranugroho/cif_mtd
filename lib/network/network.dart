const xpassword = "satkom@2345790!!";
const xusername = "satkom@234";
const token = "715f8ab555438f985b579844ea227767";

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
    return "$url/leveljabatan/updated";
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
    return "$url/jabatan/updated";
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
    return "$url/pejabat/updated";
  }

  static String deletedPejabat() {
    return "$url/pejabat/deleted";
  }
}

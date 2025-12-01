const urlAset = "http://localhost:8080/api";

class NetworkAset {
  static String kategori() {
    return "$urlAset/kategori";
  }

  static String kategoriupdate(int id) {
    return "$urlAset/kategori/$id";
  }
}

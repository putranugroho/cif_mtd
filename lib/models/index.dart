export 'neraca_item_model.dart';
export 'kota_model.dart';
export 'jabatan_model.dart';
export 'coa_sbb_model.dart';
export 'rekonsiliasi_piutang_hutang_model.dart';
export 'sbb_khusus_item_model.dart';
export 'sandi_bank_model.dart';
export 'coa_sbb_item_model.dart';
export 'karyawan_model.dart';
export 'users_menu_model.dart';
export 'users_shift_model.dart';
export 'kantor_model.dart';
export 'gl_view_model.dart';
export 'rekon_bank_item_model.dart';
export 'users_model.dart';
export 'perusahaan_model.dart';
export 'metode_penyusutan_model.dart';
export 'transaksi_bayar_pendapatan_dimuka_model.dart';
export 'level_user.dart';
export 'neraca_model.dart';
export 'level_user_modul.dart';
export 'setup_pajak_model.dart';
export 'item_modul_model.dart';
export 'kelurahan_model.dart';
export 'golongan_aset_model.dart';
export 'kelompok_aset_model.dart';
export 'piutang_hutang_model.dart';
export 'akses_point_model.dart';
export 'rekon_bank_model.dart';
export 'pembayaran_hutang_piutang_model.dart';
export 'bank_model.dart';
export 'provinsi_model.dart';
export 'aktivasi_model.dart';
export 'kecamatan_model.dart';
export 'level_model.dart';
export 'rekon_aset_model.dart';
export 'golongan_sbb_khusus_model.dart';
export 'pejabat_model.dart';
export 'modul_model.dart';
export 'otorisasi_model.dart';
export 'setup_trans_model.dart';
export 'coa_model.dart';
export 'ao_model.dart';
export 'closing_eom_setup_model.dart';
export 'inventaris_model.dart';
export 'inquery_gl_model.dart';
export 'item_category_modul_model.dart';
export 'customer_supplier_model.dart';
export 'sbb_khusus_model.dart';
export 'user_akses_point_model.dart';
export 'menu_model.dart';
export 'transaksi_model.dart';
import 'package:quiver/core.dart';

T? checkOptional<T>(Optional<T?>? optional, T? Function()? def) {
  // No value given, just take default value
  if (optional == null) return def?.call();

  // We have an input value
  if (optional.isPresent) return optional.value;

  // We have a null inside the optional
  return null;
}

export 'neraca_item_model.dart';
export 'jabatan_model.dart';
export 'coa_sbb_model.dart';
export 'sandi_bank_model.dart';
export 'coa_sbb_item_model.dart';
export 'users_menu_model.dart';
export 'kantor_model.dart';
export 'gl_view_model.dart';
export 'users_model.dart';
export 'perusahaan_model.dart';
export 'neraca_model.dart';
export 'setup_pajak_model.dart';
export 'golongan_aset_model.dart';
export 'kelompok_aset_model.dart';
export 'piutang_hutang_model.dart';
export 'bank_model.dart';
export 'aktivasi_model.dart';
export 'level_model.dart';
export 'golongan_sbb_khusus_model.dart';
export 'pejabat_model.dart';
export 'otorisasi_model.dart';
export 'setup_trans_model.dart';
export 'coa_model.dart';
export 'ao_model.dart';
export 'inventaris_model.dart';
export 'customer_supplier_model.dart';
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

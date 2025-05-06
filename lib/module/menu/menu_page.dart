import 'package:accounting/module/aktivasi_users/aktivasi_users_page.dart';
import 'package:accounting/module/closing_eom/closing_eom_page.dart';
import 'package:accounting/module/dashboard/dashboard_page.dart';
import 'package:accounting/module/gl/gl_page.dart';
import 'package:accounting/module/hutang_piutang/hutang_piutang_page.dart';
import 'package:accounting/module/inventaris/jual_beli/jual_beli_page.dart';
import 'package:accounting/module/inventaris/laporan/laporan_inventaris_page.dart';
import 'package:accounting/module/inventaris/otorisasi/otorisasi_inventaris_page.dart';
import 'package:accounting/module/inventaris/penempatan/penempatan_page.dart';
import 'package:accounting/module/inventaris/pengadaan/pengadaan_page.dart';
import 'package:accounting/module/inventaris/revaluasi/revaluasi_page.dart';
import 'package:accounting/module/jurnal/jurnal_page.dart';
import 'package:accounting/module/laba_rugi/laba_rugi_berjalan_page.dart';
import 'package:accounting/module/laba_rugi/laba_rugi_periode_page.dart';
import 'package:accounting/module/level_user/level_user_page.dart';
import 'package:accounting/module/master/ao/ao_page.dart';
import 'package:accounting/module/master/bank/bank_page.dart';
import 'package:accounting/module/master/customer/customer_page.dart';
import 'package:accounting/module/master/laporan/laporan_master_page.dart';
import 'package:accounting/module/master/otorisasi/otorisasi_master_page.dart';
import 'package:accounting/module/master/users/users_page.dart';
import 'package:accounting/module/menu/menu_notifier.dart';
import 'package:accounting/module/menu/menu_widget.dart';
import 'package:accounting/module/neraca/neraca_berjalan_page.dart';
import 'package:accounting/module/pejabat/pejabat_page.dart';
import 'package:accounting/module/pembayaran_hutang/pembayaran_hutang_page.dart';
import 'package:accounting/module/perantara/perantara_aktiva_page.dart';
import 'package:accounting/module/perantara/perantara_pasiva_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_aset_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_bank_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_hutang_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_perantara_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_perantara_pasiva_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_piutang_page.dart';
import 'package:accounting/module/rekonsiliasi/rekonsiliasi_transaksi_pending_page.dart';
import 'package:accounting/module/setup/aktivasi/aktivasi_page.dart';
import 'package:accounting/module/setup/coa/coa_page.dart';
import 'package:accounting/module/setup/golongan_aset/golongan_aset_page.dart';
import 'package:accounting/module/setup/jabatan/jabatan_page.dart';
import 'package:accounting/module/setup/kantor/kantor_page.dart';
import 'package:accounting/module/setup/kelompok_aset/kelompok_aset_page.dart';
import 'package:accounting/module/setup/laporan/laporan_setup_page.dart';
import 'package:accounting/module/setup/level/level_page.dart';
import 'package:accounting/module/setup/pajak/setup_pajak_page.dart';
import 'package:accounting/module/setup/penyusutan/penyusutan_page.dart';
import 'package:accounting/module/setup/perusahaan/perusahaan_page.dart';
import 'package:accounting/module/setup/sbb_hutang_piutang/sbb_hutang_piutang_page.dart';
import 'package:accounting/module/setup/sbb_khsus/sbb_khusus_page.dart';
import 'package:accounting/module/setup/sbb_khsus/tambah_kelompok_sbb_khusus_page.dart';
import 'package:accounting/module/setup/setup_transaksi/setup_transaksi_page.dart';
import 'package:accounting/module/setup_closing_eom/setup_closing_eom_page.dart';
import 'package:accounting/module/setup_otorisasi/setup_otorisasi_page.dart';
import 'package:accounting/module/transaksi/back_date/back_date_page.dart';
import 'package:accounting/module/transaksi/bank/bank_transaksi_page.dart';
import 'package:accounting/module/transaksi/banyak_transaksi/banyak_transaksi_page.dart';
import 'package:accounting/module/transaksi/bayar_dimuka/bayar_dimuka_page.dart';
import 'package:accounting/module/transaksi/hutang/hutang_page.dart';
import 'package:accounting/module/transaksi/kas_kecil/kas_kecil_page.dart';
import 'package:accounting/module/transaksi/laporan/laporan_transaksi_page.dart';
import 'package:accounting/module/transaksi/otorisasi/otorisasi_transaksi_page.dart';
import 'package:accounting/module/transaksi/piutang/piutang_page.dart';
import 'package:accounting/module/transaksi/satu_transaksi/satu_transaksi_page.dart';
import 'package:accounting/module/transaksi/transaksi_hutang/transaksi_hutang_page.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../neraca/neraca_periode_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuNotifier(context: context),
      child: Consumer<MenuNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 330,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: colorPrimary),
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () => value.gantimenu(0),
                      child: Container(
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.dashboard,
                              height: 30,
                              color: value.page == 0
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Dashboard",
                              style: TextStyle(
                                fontSize: 16,
                                color: value.page == 0
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    MenuSetupWidget(value: value),
                    SizedBox(
                      height: 24,
                    ),
                    MenuMasterWidget(
                      value: value,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    MenuInventarisWidget(value: value),
                    SizedBox(
                      height: 24,
                    ),
                    MenuTransaksiWidget(value: value),
                    SizedBox(
                      height: 24,
                    ),
                    MenuHutangPiutangWidget(value: value),
                    SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      onTap: () => value.gantimenu(26),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.user,
                              height: 30,
                              color: value.page == 26
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Aktivasi Users",
                              style: TextStyle(
                                fontSize: 16,
                                color: value.page == 26
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      onTap: () => value.gantimenu(27),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.eom,
                              height: 30,
                              color: value.page == 27
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Closing EOM",
                              style: TextStyle(
                                fontSize: 16,
                                color: value.page == 27
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      onTap: () => value.gantimenu(28),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.settings,
                              height: 30,
                              color: value.page == 28
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                fontSize: 16,
                                color: value.page == 28
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      // onTap: () => value.gantimenu(28),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.logout,
                              height: 30,
                              color: value.page == 30
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                fontSize: 16,
                                color: value.page == 30
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: value.page == 0
                      ? DashboardPage()
                      : value.page == 1
                          ? KantorPage()
                          : value.page == 2
                              ? CoaPage()
                              : value.page == 3
                                  ? PenyusutanPage()
                                  : value.page == 4
                                      ? SetupTransaksiPage()
                                      : value.page == 5
                                          ? LaporanSetupPage()
                                          : value.page == 6
                                              ? UsersPage()
                                              : value.page == 7
                                                  ? BankPage()
                                                  : value.page == 8
                                                      ? CustomerPage()
                                                      : value.page == 9
                                                          ? OtorisasiMasterPage()
                                                          : value.page == 10
                                                              ? LaporanMasterPage()
                                                              : value.page == 11
                                                                  ? PengadaanPage()
                                                                  : value.page ==
                                                                          12
                                                                      ? PenempatanPage()
                                                                      : value.page ==
                                                                              13
                                                                          ? RevaluasiPage()
                                                                          : value.page == 14
                                                                              ? JualBeliPage()
                                                                              : value.page == 15
                                                                                  ? OtorisasiInventarisPage()
                                                                                  : value.page == 16
                                                                                      ? LaporanInventarisPage()
                                                                                      : value.page == 17
                                                                                          ? SatuTransaksiPage()
                                                                                          : value.page == 18
                                                                                              ? BanyakTransaksiPage()
                                                                                              : value.page == 19
                                                                                                  ? KasKecilPage()
                                                                                                  : value.page == 20
                                                                                                      ? BankTransaksiPage()
                                                                                                      : value.page == 21
                                                                                                          ? HutangPage()
                                                                                                          : value.page == 22
                                                                                                              ? PiutangPage()
                                                                                                              : value.page == 23
                                                                                                                  ? BackDatePage()
                                                                                                                  : value.page == 24
                                                                                                                      ? OtorisasiTransaksiPage()
                                                                                                                      : value.page == 25
                                                                                                                          ? LaporanTransaksiPage()
                                                                                                                          : value.page == 26
                                                                                                                              ? AktivasiUsersPage()
                                                                                                                              : value.page == 27
                                                                                                                                  ? ClosingEomPage()
                                                                                                                                  : value.page == 28
                                                                                                                                      ? PerusahaanPage()
                                                                                                                                      : value.page == 29
                                                                                                                                          ? JabatanPage()
                                                                                                                                          : value.page == 30
                                                                                                                                              ? PejabatPage()
                                                                                                                                              : value.page == 31
                                                                                                                                                  ? LevelPage()
                                                                                                                                                  : value.page == 32
                                                                                                                                                      ? SetupPajakPage()
                                                                                                                                                      : value.page == 33
                                                                                                                                                          ? KelompokAsetPage()
                                                                                                                                                          : value.page == 34
                                                                                                                                                              ? GolonganAsetPage()
                                                                                                                                                              : value.page == 35
                                                                                                                                                                  ? AoPage()
                                                                                                                                                                  : value.page == 36
                                                                                                                                                                      ? AktivasiPage()
                                                                                                                                                                      : value.page == 37
                                                                                                                                                                          ? SbbKhususPage()
                                                                                                                                                                          : value.page == 38
                                                                                                                                                                              ? SetupClosingEomPage()
                                                                                                                                                                              : value.page == 39
                                                                                                                                                                                  ? SetupOtorisasiPage()
                                                                                                                                                                                  : value.page == 43
                                                                                                                                                                                      ? JurnalPage()
                                                                                                                                                                                      : value.page == 44
                                                                                                                                                                                          ? NeracaBerjalanPage()
                                                                                                                                                                                          : value.page == 45
                                                                                                                                                                                              ? NeracaPeriodePage()
                                                                                                                                                                                              : value.page == 46
                                                                                                                                                                                                  ? LabaRugiBerjalanPage()
                                                                                                                                                                                                  : value.page == 47
                                                                                                                                                                                                      ? TambahKelompokSbbKhususPage()
                                                                                                                                                                                                      : value.page == 48
                                                                                                                                                                                                          ? GlPage()
                                                                                                                                                                                                          : value.page == 49
                                                                                                                                                                                                              ? LabaRugiPeriodePage()
                                                                                                                                                                                                              : value.page == 50
                                                                                                                                                                                                                  ? RekonsiliasiBankPage()
                                                                                                                                                                                                                  : value.page == 51
                                                                                                                                                                                                                      ? RekonsiliasiHutangPage()
                                                                                                                                                                                                                      : value.page == 52
                                                                                                                                                                                                                          ? RekonsiliasiPiutangPage()
                                                                                                                                                                                                                          : value.page == 53
                                                                                                                                                                                                                              ? RekonsiliasiAsetPage()
                                                                                                                                                                                                                              : value.page == 54
                                                                                                                                                                                                                                  ? RekonsiliasiTransaksiPendingPage()
                                                                                                                                                                                                                                  : value.page == 55
                                                                                                                                                                                                                                      ? RekonsiliasiPerantaraPage()
                                                                                                                                                                                                                                      : value.page == 57
                                                                                                                                                                                                                                          ? PerantaraAktivaPage()
                                                                                                                                                                                                                                          : value.page == 58
                                                                                                                                                                                                                                              ? PembayaranHutangPage()
                                                                                                                                                                                                                                              : value.page == 59
                                                                                                                                                                                                                                                  ? BayarDimukaPage()
                                                                                                                                                                                                                                                  : value.page == 60
                                                                                                                                                                                                                                                      ? LevelUserPage()
                                                                                                                                                                                                                                                      : value.page == 61
                                                                                                                                                                                                                                                          ? HutangPiutangPage(tipe: 1, jenis: 1)
                                                                                                                                                                                                                                                          : value.page == 62
                                                                                                                                                                                                                                                              ? HutangPiutangPage(tipe: 2, jenis: 1)
                                                                                                                                                                                                                                                              : value.page == 63
                                                                                                                                                                                                                                                                  ? HutangPiutangPage(tipe: 1, jenis: 2)
                                                                                                                                                                                                                                                                  : value.page == 64
                                                                                                                                                                                                                                                                      ? HutangPiutangPage(tipe: 2, jenis: 2)
                                                                                                                                                                                                                                                                      : value.page == 65
                                                                                                                                                                                                                                                                          ? SbbHutangPiutangPage()
                                                                                                                                                                                                                                                                          : Container())
            ],
          ),
        )),
      ),
    );
  }
}

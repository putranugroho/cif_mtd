import 'package:cif/module/menu/menu_notifier.dart';
import 'package:flutter/material.dart';

import '../../utils/images_path.dart';

class MenuSetupWidget extends StatefulWidget {
  final MenuNotifier value;
  const MenuSetupWidget({super.key, required this.value});

  @override
  State<MenuSetupWidget> createState() => _MenuSetupWidgetState();
}

class _MenuSetupWidgetState extends State<MenuSetupWidget> {
  bool _isExpanded = false;
  int _isExpandedSub = 0;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        decoration: BoxDecoration(
          color: _isExpanded ? const Color.fromARGB(255, 0, 125, 228) : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.settings, height: 30, color: Colors.white),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "SETUP",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => widget.value.gantimenu(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 1 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.building,
                  height: 30,
                  color: widget.value.page == 1 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Data Kantor",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 1 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(74),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 74 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 74 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "PT",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 74 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(75),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 75 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 75 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Sandi BI/OJK",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 75 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(76),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 76 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 76 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Tabungan",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 76 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(77),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 77 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 77 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Deposito",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 77 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(85),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 85 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 85 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Kredit",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 85 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(78),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 78 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 78 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Hari Libur",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 78 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 2 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.accounting,
                  height: 30,
                  color: widget.value.page == 2 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "GL",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 2 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 2 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.accounting,
                  height: 30,
                  color: widget.value.page == 2 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Batas Login",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 2 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 2 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.accounting,
                  height: 30,
                  color: widget.value.page == 2 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "RAK",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 2 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 2 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.accounting,
                  height: 30,
                  color: widget.value.page == 2 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "EOD/EOM",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 2 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuMasterWidget extends StatefulWidget {
  final MenuNotifier value;
  const MenuMasterWidget({super.key, required this.value});

  @override
  State<MenuMasterWidget> createState() => _MenuMasterWidgetState();
}

class _MenuMasterWidgetState extends State<MenuMasterWidget> {
  bool _isExpanded = false;
  bool _isExpandedSub = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        decoration: BoxDecoration(
          color: _isExpanded ? const Color.fromARGB(255, 0, 125, 228) : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.setting, height: 30, color: Colors.white),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "MASTER",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => widget.value.gantimenu(79),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 79 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 79 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Master Users",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 79 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(80),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 80 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 80 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Akses",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 80 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(84),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 84 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 84 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Rate Deposito",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 84 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(81),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 81 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 81 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "AO/Kolektor",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 81 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(81),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 81 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 81 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Transaksi",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 81 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(81),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 81 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 81 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Mitra Kerja",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 81 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(81),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 81 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.setting,
                  height: 30,
                  color: widget.value.page == 81 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Teriminal ATM",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 81 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuCustomerWidget extends StatefulWidget {
  final MenuNotifier value;
  const MenuCustomerWidget({super.key, required this.value});

  @override
  State<MenuCustomerWidget> createState() => _MenuCustomerWidgetState();
}

class _MenuCustomerWidgetState extends State<MenuCustomerWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        decoration: BoxDecoration(
          color: _isExpanded ? const Color.fromARGB(255, 0, 125, 228) : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.prices, height: 30, color: Colors.white),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "CUSTOMER",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => widget.value.gantimenu(11),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 11 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.cart,
                  height: 30,
                  color: widget.value.page == 11 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Perorangan",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 11 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(12),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 12 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.placement,
                  height: 30,
                  color: widget.value.page == 12 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "PT",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 12 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuHutangPiutangWidget extends StatefulWidget {
  final MenuNotifier value;
  const MenuHutangPiutangWidget({super.key, required this.value});

  @override
  State<MenuHutangPiutangWidget> createState() => _MenuHutangPiutangWidgetState();
}

class _MenuHutangPiutangWidgetState extends State<MenuHutangPiutangWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        decoration: BoxDecoration(
          color: _isExpanded ? const Color.fromARGB(255, 0, 125, 228) : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.bill, height: 30, color: Colors.white),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "KELOLA HUTANG/ PIUTANG",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => widget.value.gantimenu(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 8 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.user,
                  height: 30,
                  color: widget.value.page == 8 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Customer/Supplier",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 8 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(61),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 61 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.rupiahs,
                  height: 30,
                  color: widget.value.page == 61 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Hutang / Piutang",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 61 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(71),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 71 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.rupiahs,
                  height: 30,
                  color: widget.value.page == 71 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Laporan",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 71 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuTransaksiWidget extends StatefulWidget {
  final MenuNotifier value;
  const MenuTransaksiWidget({super.key, required this.value});

  @override
  State<MenuTransaksiWidget> createState() => _MenuTransaksiWidgetState();
}

class _MenuTransaksiWidgetState extends State<MenuTransaksiWidget> {
  bool _isExpanded = false;
  int _isExpandedSub = 0;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        decoration: BoxDecoration(
          color: _isExpanded ? const Color.fromARGB(255, 0, 125, 228) : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.bill, height: 30, color: Colors.white),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "TRANSAKSI",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => widget.value.gantimenu(72),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 72 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 72 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Penerimaan",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 72 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(73),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 73 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 73 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Pengeluaran",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 73 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(86),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 86 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 86 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Koreksi Barang",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 86 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(83),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 83 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 83 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Tracking Pengiriman",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 83 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MenuLaporanWidget extends StatefulWidget {
  final MenuNotifier value;
  const MenuLaporanWidget({super.key, required this.value});

  @override
  State<MenuLaporanWidget> createState() => _MenuLaporanWidgetState();
}

class _MenuLaporanWidgetState extends State<MenuLaporanWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Container(
        decoration: BoxDecoration(
          color: _isExpanded ? const Color.fromARGB(255, 0, 125, 228) : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.eom, height: 30, color: Colors.white),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "LAPORAN",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => widget.value.gantimenu(44),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 44 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 44 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Neraca Berjalan",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 44 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(46),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 46 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 46 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Laba Rugi Berjalan",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 46 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(45),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 45 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 45 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Neraca Periode",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 45 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(49),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 49 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 49 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Laba Rugi Periode",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 49 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => widget.value.gantimenu(48),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.value.page == 48 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: widget.value.page == 48 ? Colors.black : Colors.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "GL / COA",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.value.page == 48 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

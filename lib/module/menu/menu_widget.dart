import 'package:accounting/module/menu/menu_notifier.dart';
import 'package:flutter/material.dart';

import '../../utils/images_path.dart';

class MenuSetupWidget extends StatelessWidget {
  final MenuNotifier value;
  const MenuSetupWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Container(
        child: Row(
          children: [
            Image.asset(ImageAssets.settings, height: 30, color: Colors.white),
            SizedBox(
              width: 16,
            ),
            Text(
              "Setup",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          shape: Border(),
          expandedAlignment: Alignment.centerLeft,
          collapsedIconColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Image.asset(ImageAssets.building,
                    height: 30, color: Colors.white),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Kantor",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ),
          children: [
            InkWell(
              onTap: () => value.gantimenu(1),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      ImageAssets.building,
                      height: 30,
                      color: value.page == 1 ? Colors.white : Colors.white70,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Data Kantor",
                      style: TextStyle(
                        fontSize: 16,
                        color: value.page == 1 ? Colors.white : Colors.white70,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => value.gantimenu(31),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      ImageAssets.user,
                      height: 30,
                      color: value.page == 31 ? Colors.white : Colors.white70,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Data Level",
                      style: TextStyle(
                        fontSize: 16,
                        color: value.page == 31 ? Colors.white : Colors.white70,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => value.gantimenu(29),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      ImageAssets.group,
                      height: 30,
                      color: value.page == 29 ? Colors.white : Colors.white70,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Data Jabatan",
                      style: TextStyle(
                        fontSize: 16,
                        color: value.page == 29 ? Colors.white : Colors.white70,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => value.gantimenu(30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      ImageAssets.user,
                      height: 30,
                      color: value.page == 30 ? Colors.white : Colors.white70,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Data Pejabat",
                      style: TextStyle(
                        fontSize: 16,
                        color: value.page == 30 ? Colors.white : Colors.white70,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => value.gantimenu(2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.accounting,
                  height: 30,
                  color: value.page == 2 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Chart of Account",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 2 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(3),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.trend,
                  height: 30,
                  color: value.page == 3 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Penyusutan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 3 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            shape: Border(),
            expandedAlignment: Alignment.centerLeft,
            collapsedIconColor: Colors.white,
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(ImageAssets.setting,
                      height: 30, color: Colors.white),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Transaksi",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
            children: [
              InkWell(
                onTap: () => value.gantimenu(4),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset(
                        ImageAssets.bill,
                        height: 30,
                        color: value.page == 4 ? Colors.white : Colors.white70,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Setup Transaksi",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              value.page == 4 ? Colors.white : Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => value.gantimenu(32),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset(
                        ImageAssets.bill,
                        height: 30,
                        color: value.page == 32 ? Colors.white : Colors.white70,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Pajak",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              value.page == 32 ? Colors.white : Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
        InkWell(
          onTap: () => value.gantimenu(5),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: value.page == 5 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Laporan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 5 ? Colors.white : Colors.white70,
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

class MenuMasterWidget extends StatelessWidget {
  final MenuNotifier value;
  const MenuMasterWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Container(
        child: Row(
          children: [
            Image.asset(ImageAssets.setting, height: 30, color: Colors.white),
            SizedBox(
              width: 16,
            ),
            Text(
              "Master",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => value.gantimenu(6),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.group,
                  height: 30,
                  color: value.page == 6 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Users",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 6 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(7),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.bank,
                  height: 30,
                  color: value.page == 7 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Bank",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 7 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.user,
                  height: 30,
                  color: value.page == 8 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Customer/Supplier",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 8 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(9),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.click,
                  height: 30,
                  color: value.page == 9 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Otorisasi",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 9 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: value.page == 10 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Laporan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 10 ? Colors.white : Colors.white70,
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

class MenuInventarisWidget extends StatelessWidget {
  final MenuNotifier value;
  const MenuInventarisWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Container(
        child: Row(
          children: [
            Image.asset(ImageAssets.prices, height: 30, color: Colors.white),
            SizedBox(
              width: 16,
            ),
            Text(
              "Inventaris",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => value.gantimenu(11),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.cart,
                  height: 30,
                  color: value.page == 11 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Pengadaan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 11 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(12),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.placement,
                  height: 30,
                  color: value.page == 12 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Penempatan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 12 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(13),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.audit,
                  height: 30,
                  color: value.page == 13 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Revaluasi",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 13 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(14),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.carts,
                  height: 30,
                  color: value.page == 14 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Jual/Beli",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 14 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.click,
                  height: 30,
                  color: value.page == 15 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Otorisasi",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 15 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: value.page == 16 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Laporan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 16 ? Colors.white : Colors.white70,
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

class MenuTransaksiWidget extends StatelessWidget {
  final MenuNotifier value;
  const MenuTransaksiWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: Border(),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Container(
        child: Row(
          children: [
            Image.asset(ImageAssets.bill, height: 30, color: Colors.white),
            SizedBox(
              width: 16,
            ),
            Text(
              "Transaksi",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      children: [
        InkWell(
          onTap: () => value.gantimenu(17),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: value.page == 17 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Satu Transaksi",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 17 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(18),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: value.page == 18 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Banyak Transaksi",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 18 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(19),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.rupiah,
                  height: 30,
                  color: value.page == 19 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Kas Kecil",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 19 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.bank,
                  height: 30,
                  color: value.page == 20 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Bank",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 20 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(21),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.debt,
                  height: 30,
                  color: value.page == 21 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Hutang",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 21 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(22),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.rupiahs,
                  height: 30,
                  color: value.page == 22 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Piutang",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 22 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(23),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.calendar,
                  height: 30,
                  color: value.page == 23 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Back date",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 23 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(24),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.click,
                  height: 30,
                  color: value.page == 24 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Otorisasi",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 24 ? Colors.white : Colors.white70,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => value.gantimenu(25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.report,
                  height: 30,
                  color: value.page == 25 ? Colors.white : Colors.white70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Laporan",
                  style: TextStyle(
                    fontSize: 16,
                    color: value.page == 25 ? Colors.white : Colors.white70,
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

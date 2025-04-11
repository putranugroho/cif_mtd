import 'package:accounting/module/setup/sbb_khsus/sbb_khusus_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../models/coa_model.dart';
import '../../../utils/colors.dart';

class SbbKhususPage extends StatelessWidget {
  const SbbKhususPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SbbKhususNotifier(context: context),
      child: Consumer<SbbKhususNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "SBB Khusus",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => value.tambah(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorPrimary,
                                border: Border.all(
                                  width: 2,
                                  color: colorPrimary,
                                ),
                              ),
                              child: Text(
                                "Tambah SBB Khusus",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: value.dialog
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                      )
                    : SizedBox(),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: value.dialog
                    ? Container(
                        width: 600,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Tambah SBB Khusus",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => value.tutup(),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.close),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Pilih SBB Khusus",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "*",
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownSearch<String>(
                                    popupProps:
                                        const PopupPropsMultiSelection.menu(
                                      showSearchBox:
                                          true, // Aktifkan fitur pencarian
                                    ),
                                    selectedItem: value.sbbKhusus,
                                    items: value.listSBBKhusus,
                                    itemAsString: (e) => "${e}",
                                    onChanged: (e) {
                                      value.pilihSbbKhusus(e!);
                                    },
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      baseStyle: TextStyle(fontSize: 16),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: "Pilih SBB Khusus",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            value.sbbKhusus != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  Text("Pilih Sub Buku Besar")),
                                          InkWell(
                                            onTap: () =>
                                                value.tambahParameter(),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: colorPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                "Pilih Semua",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ListView.builder(
                                          itemCount: value.list
                                              .where((e) => e.jnsAcc == "C")
                                              .length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            final data = value.list
                                                .where((e) => e.jnsAcc == "C")
                                                .toList()[i];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: value
                                                              .listAdd.isEmpty
                                                          ? false
                                                          : value.listAdd
                                                                  .where((e) =>
                                                                      e == data)
                                                                  .isNotEmpty
                                                              ? true
                                                              : false,
                                                      onChanged: (e) {
                                                        value.pilihCoa(data);
                                                      },
                                                      activeColor: colorPrimary,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                        child: TextFormField(
                                                      readOnly: true,
                                                      controller:
                                                          value.listSbb[i],
                                                      decoration: InputDecoration(
                                                          fillColor:
                                                              Colors.grey[200],
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16))),
                                                    )),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                        child: TextFormField(
                                                      readOnly: true,
                                                      controller:
                                                          value.listNama[i],
                                                      decoration: InputDecoration(
                                                          fillColor:
                                                              Colors.grey[200],
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16))),
                                                    ))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            );
                                          }),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          ButtonPrimary(
                                            onTap: () {},
                                            name: "Simpan",
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                      )
                    : SizedBox(),
              )
            ],
          ),
        )),
      ),
    );
  }
}

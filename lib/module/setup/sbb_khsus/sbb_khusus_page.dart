import 'package:accounting/models/index.dart';
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
                                  child: DropdownSearch<GolonganSbbKhususModel>(
                                    popupProps:
                                        const PopupPropsMultiSelection.menu(
                                      showSearchBox:
                                          true, // Aktifkan fitur pencarian
                                    ),
                                    selectedItem: value.golonganSbbKhususModel,
                                    items: value.listGolongan,
                                    itemAsString: (e) =>
                                        "(${e.kodeGolongan}) ${e.namaGolongan}",
                                    onChanged: (e) {
                                      value.pilihGolongan(e!);
                                    },
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      baseStyle: TextStyle(fontSize: 16),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: "Pilih Golongan",
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
                            value.golonganSbbKhususModel != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  Text("Pilih Sub Buku Besar")),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ListView.builder(
                                          itemCount: value.listGl.length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            final data = value.listGl[i];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  "${data.namaSbb}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                value.golonganSbbKhususModel!
                                                            .lebihSatuAkun ==
                                                        "Y"
                                                    ? ListView.builder(
                                                        itemCount:
                                                            data.items.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemBuilder:
                                                            (context, b) {
                                                          final a =
                                                              data.items[b];
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                      activeColor:
                                                                          colorPrimary,
                                                                      value: value
                                                                              .listGlAdd
                                                                              .isNotEmpty
                                                                          ? value.listGlAdd.where((e) => e == a).isNotEmpty
                                                                              ? true
                                                                              : false
                                                                          : false,
                                                                      onChanged: (e) {
                                                                        value.pilihCoa(
                                                                            a);
                                                                      }),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Expanded(
                                                                      child: Text(
                                                                          "(${a.nosbb}) ${a.namaSbb}")),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              )
                                                            ],
                                                          );
                                                        })
                                                    : ListView.builder(
                                                        itemCount:
                                                            data.items.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemBuilder:
                                                            (context, b) {
                                                          final a =
                                                              data.items[b];
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Radio(
                                                                      activeColor:
                                                                          colorPrimary,
                                                                      value: a,
                                                                      groupValue:
                                                                          value
                                                                              .inqueryGlModel,
                                                                      onChanged:
                                                                          (e) {
                                                                        value.pilihSbbSatu(
                                                                            a);
                                                                      }),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Expanded(
                                                                      child: Text(
                                                                          "(${a.nosbb}) ${a.namaSbb}")),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              )
                                                            ],
                                                          );
                                                        })
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

import 'package:accounting/module/akses_point/akses_point_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/button_custom.dart';
import '../../utils/colors.dart';

class AksesPointPage extends StatelessWidget {
  const AksesPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AksesPointNotifier(context: context),
      child: Consumer<AksesPointNotifier>(
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
                              "Akses Point",
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
                                "Tambah Akses Point",
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
                bottom: 0,
                right: 0,
                child: value.dialog
                    ? Container(
                        padding: EdgeInsets.all(20),
                        width: 700,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Form(
                          key: value.keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      value.editData
                                          ? "Ubah / Hapus Akses Point"
                                          : "Tambah Akses Point",
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
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("No Akses"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Akses ID"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Lokasi"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Radio(
                                              value: "Kantor",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Kantor"),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "Luar Kantor",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Luar Kantor"),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "Karyawan",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Rumah Karyawan"),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Kantor"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Alamat"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Keterangan"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Tipe Akses"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Radio(
                                              value: "LAN",
                                              groupValue: value.akses,
                                              activeColor: colorPrimary,
                                              onChanged: (e) {
                                                value.pilihAkses(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("LAN"),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "WIFI",
                                              groupValue: value.akses,
                                              activeColor: colorPrimary,
                                              onChanged: (e) {
                                                value.pilihAkses(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("WIFI"),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              const SizedBox(height: 16),
                              ButtonPrimary(
                                onTap: () {
                                  value.cek();
                                },
                                name: "Simpan",
                              ),
                              value.editData
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 16),
                                        ButtonDanger(
                                          onTap: () {
                                            value.confirm();
                                          },
                                          name: "Hapus",
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
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

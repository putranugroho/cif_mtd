import 'package:cif/module/setup/perusahaan/perusahaan_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PerusahaanPage extends StatelessWidget {
  const PerusahaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PerusahaanNotifier(context: context),
      child: Consumer<PerusahaanNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Kode Perusahaan",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.kodePerusahaan,
                          enabled: false,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Kode Perusahaan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Nama Perusahaan",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.namaPerusahaan,

                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Nama Perusahaan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Provinsi",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.provinsi,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Provinsi",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Kota / Kabupaten",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.kota,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Kota / Kabupaten",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Kecamatan",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "*",
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.done,
                                  controller: value.kecamatan,
                                  maxLines: 1,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Wajib diisi";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintText: "Kecamatan",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Kelurahan",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "*",
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.done,
                                  controller: value.kelurahan,

                                  maxLines: 1,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Wajib diisi";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintText: "Kelurahan",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          "Kode Pos",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "*",
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.kodePos,
                                      maxLines: 1,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Wajib diisi";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintText: "Kelurahan",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Alamat",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.newline,
                          controller: value.alamat,
                          maxLines: 3,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Kota / Kabupaten",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "NPWP",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.npwp,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "NPWP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Direktu Utama",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.dirut,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Direktur Utama",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Direktu Keuangan",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.dirKeuangan,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Direktur Keuangan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Text(
                              "Direktu Operasional",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.dirOperasi,
                          maxLines: 1,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Direktur Operasional",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ButtonPrimary(
                          onTap: () {},
                          name: "Simpan",
                        ),
                        const SizedBox(
                          height: 48,
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        )),
      ),
    );
  }
}

import 'package:accounting/models/index.dart';
import 'package:accounting/module/user_akses_point/user_akses_point_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class UserAksesPointPage extends StatelessWidget {
  const UserAksesPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserAksesPointNotifier(context: context),
      child: Consumer<UserAksesPointNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "User Akses Point",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text("Cari user"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 200,
                          child: TypeAheadField<UsersModel>(
                            controller: value.namaKaryawan,
                            suggestionsCallback: (search) =>
                                value.getInquery(search),
                            builder: (context, controller, focusNode) {
                              return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Cari Akun',
                                  ));
                            },
                            itemBuilder: (context, city) {
                              return ListTile(
                                title: Text(city.namauser),
                                subtitle: Text(city.userid),
                              );
                            },
                            onSelected: (city) {
                              // value.selectInvoice(city);
                              value.piliAkunKaryawan(city);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text("User ID"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            controller: value.nikKaryawan,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "User ID",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            controller: value.namaKantor,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "Kantor",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            value.getUsersAksesPoint();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              "Tambah",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

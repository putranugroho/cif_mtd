import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SandiBankModel {

  const SandiBankModel({
    required this.id,
    required this.sandiBic,
    required this.namaBank,
    required this.namaBankSingkat,
    required this.kodeBank,
    required this.kodeKantor,
  });

  final int id;
  final String sandiBic;
  final String namaBank;
  final String namaBankSingkat;
  final String kodeBank;
  final String kodeKantor;

  factory SandiBankModel.fromJson(Map<String,dynamic> json) => SandiBankModel(
    id: json['id'] as int,
    sandiBic: json['sandi_bic'].toString(),
    namaBank: json['nama_bank'].toString(),
    namaBankSingkat: json['nama_bank_singkat'].toString(),
    kodeBank: json['kode_bank'].toString(),
    kodeKantor: json['kode_kantor'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'sandi_bic': sandiBic,
    'nama_bank': namaBank,
    'nama_bank_singkat': namaBankSingkat,
    'kode_bank': kodeBank,
    'kode_kantor': kodeKantor
  };

  SandiBankModel clone() => SandiBankModel(
    id: id,
    sandiBic: sandiBic,
    namaBank: namaBank,
    namaBankSingkat: namaBankSingkat,
    kodeBank: kodeBank,
    kodeKantor: kodeKantor
  );


  SandiBankModel copyWith({
    int? id,
    String? sandiBic,
    String? namaBank,
    String? namaBankSingkat,
    String? kodeBank,
    String? kodeKantor
  }) => SandiBankModel(
    id: id ?? this.id,
    sandiBic: sandiBic ?? this.sandiBic,
    namaBank: namaBank ?? this.namaBank,
    namaBankSingkat: namaBankSingkat ?? this.namaBankSingkat,
    kodeBank: kodeBank ?? this.kodeBank,
    kodeKantor: kodeKantor ?? this.kodeKantor,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SandiBankModel && id == other.id && sandiBic == other.sandiBic && namaBank == other.namaBank && namaBankSingkat == other.namaBankSingkat && kodeBank == other.kodeBank && kodeKantor == other.kodeKantor;

  @override
  int get hashCode => id.hashCode ^ sandiBic.hashCode ^ namaBank.hashCode ^ namaBankSingkat.hashCode ^ kodeBank.hashCode ^ kodeKantor.hashCode;
}

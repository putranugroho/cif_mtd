import 'package:flutter/foundation.dart';

@immutable
class RekonBankItemModel {
  const RekonBankItemModel({
    required this.nosbb,
    required this.namaSbb,
    required this.typePosting,
    required this.tglTransaksi,
    required this.saldo,
    required this.saldoSistem,
  });

  final String nosbb;
  final String namaSbb;
  final String typePosting;
  final String tglTransaksi;
  final double saldo;
  final double saldoSistem;

  factory RekonBankItemModel.fromJson(Map<String, dynamic> json) => RekonBankItemModel(nosbb: json['nosbb'].toString(), namaSbb: json['nama_sbb'].toString(), typePosting: json['type_posting'].toString(), tglTransaksi: json['tgl_transaksi'].toString(), saldo: (json['saldo'] as num).toDouble(), saldoSistem: (json['saldo_sistem'] as num).toDouble());

  Map<String, dynamic> toJson() => {
        'nosbb': nosbb,
        'nama_sbb': namaSbb,
        'type_posting': typePosting,
        'tgl_transaksi': tglTransaksi,
        'saldo': saldo,
        'saldo_sistem': saldoSistem
      };

  RekonBankItemModel clone() => RekonBankItemModel(nosbb: nosbb, namaSbb: namaSbb, typePosting: typePosting, tglTransaksi: tglTransaksi, saldo: saldo, saldoSistem: saldoSistem);

  RekonBankItemModel copyWith({String? nosbb, String? namaSbb, String? typePosting, String? tglTransaksi, double? saldo, double? saldoSistem}) => RekonBankItemModel(
        nosbb: nosbb ?? this.nosbb,
        namaSbb: namaSbb ?? this.namaSbb,
        typePosting: typePosting ?? this.typePosting,
        tglTransaksi: tglTransaksi ?? this.tglTransaksi,
        saldo: saldo ?? this.saldo,
        saldoSistem: saldoSistem ?? this.saldoSistem,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is RekonBankItemModel && nosbb == other.nosbb && namaSbb == other.namaSbb && typePosting == other.typePosting && tglTransaksi == other.tglTransaksi && saldo == other.saldo && saldoSistem == other.saldoSistem;

  @override
  int get hashCode => nosbb.hashCode ^ namaSbb.hashCode ^ typePosting.hashCode ^ tglTransaksi.hashCode ^ saldo.hashCode ^ saldoSistem.hashCode;
}

import 'package:flutter/foundation.dart';

@immutable
class SetupPajakModel {
  const SetupPajakModel({
    required this.id,
    required this.tipe,
    required this.ppn,
    required this.kodePt,
    required this.maksKenaPpn,
    required this.pph23,
  });

  final int id;
  final String tipe;
  final String ppn;
  final String kodePt;
  final String maksKenaPpn;
  final String pph23;

  factory SetupPajakModel.fromJson(Map<String, dynamic> json) => SetupPajakModel(id: json['id'] as int, tipe: json['tipe'].toString(), ppn: json['ppn'].toString(), kodePt: json['kode_pt'].toString(), maksKenaPpn: json['maks_kena_ppn'].toString(), pph23: json['pph_23'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipe': tipe,
        'ppn': ppn,
        'kode_pt': kodePt,
        'maks_kena_ppn': maksKenaPpn,
        'pph_23': pph23
      };

  SetupPajakModel clone() => SetupPajakModel(id: id, tipe: tipe, ppn: ppn, kodePt: kodePt, maksKenaPpn: maksKenaPpn, pph23: pph23);

  SetupPajakModel copyWith({int? id, String? tipe, String? ppn, String? kodePt, String? maksKenaPpn, String? pph23}) => SetupPajakModel(
        id: id ?? this.id,
        tipe: tipe ?? this.tipe,
        ppn: ppn ?? this.ppn,
        kodePt: kodePt ?? this.kodePt,
        maksKenaPpn: maksKenaPpn ?? this.maksKenaPpn,
        pph23: pph23 ?? this.pph23,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetupPajakModel && id == other.id && tipe == other.tipe && ppn == other.ppn && kodePt == other.kodePt && maksKenaPpn == other.maksKenaPpn && pph23 == other.pph23;

  @override
  int get hashCode => id.hashCode ^ tipe.hashCode ^ ppn.hashCode ^ kodePt.hashCode ^ maksKenaPpn.hashCode ^ pph23.hashCode;
}

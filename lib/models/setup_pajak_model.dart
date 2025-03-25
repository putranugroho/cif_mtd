import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SetupPajakModel {

  const SetupPajakModel({
    required this.ppn,
    required this.maksKenaPpn,
    required this.pph23,
  });

  final String ppn;
  final String maksKenaPpn;
  final String pph23;

  factory SetupPajakModel.fromJson(Map<String,dynamic> json) => SetupPajakModel(
    ppn: json['ppn'].toString(),
    maksKenaPpn: json['maks_kena_ppn'].toString(),
    pph23: json['pph_23'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'ppn': ppn,
    'maks_kena_ppn': maksKenaPpn,
    'pph_23': pph23
  };

  SetupPajakModel clone() => SetupPajakModel(
    ppn: ppn,
    maksKenaPpn: maksKenaPpn,
    pph23: pph23
  );


  SetupPajakModel copyWith({
    String? ppn,
    String? maksKenaPpn,
    String? pph23
  }) => SetupPajakModel(
    ppn: ppn ?? this.ppn,
    maksKenaPpn: maksKenaPpn ?? this.maksKenaPpn,
    pph23: pph23 ?? this.pph23,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SetupPajakModel && ppn == other.ppn && maksKenaPpn == other.maksKenaPpn && pph23 == other.pph23;

  @override
  int get hashCode => ppn.hashCode ^ maksKenaPpn.hashCode ^ pph23.hashCode;
}

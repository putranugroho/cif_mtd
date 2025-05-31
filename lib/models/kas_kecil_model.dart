import 'package:flutter/foundation.dart';

@immutable
class KasKecilModel {
  const KasKecilModel({
    required this.id,
    required this.kodePt,
    required this.nosbbKasKecil,
    required this.namasbbKaskecil,
    required this.nosbbKasBon,
    required this.namasbbKasbon,
    required this.createddate,
  });

  final int id;
  final String kodePt;
  final String nosbbKasKecil;
  final String namasbbKaskecil;
  final String nosbbKasBon;
  final String namasbbKasbon;
  final String createddate;

  factory KasKecilModel.fromJson(Map<String, dynamic> json) => KasKecilModel(id: json['id'] as int, kodePt: json['kode_pt'].toString(), nosbbKasKecil: json['nosbb_kas_kecil'].toString(), namasbbKaskecil: json['namasbb_kaskecil'].toString(), nosbbKasBon: json['nosbb_kas_bon'].toString(), namasbbKasbon: json['namasbb_kasbon'].toString(), createddate: json['createddate'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_pt': kodePt,
        'nosbb_kas_kecil': nosbbKasKecil,
        'namasbb_kaskecil': namasbbKaskecil,
        'nosbb_kas_bon': nosbbKasBon,
        'namasbb_kasbon': namasbbKasbon,
        'createddate': createddate
      };

  KasKecilModel clone() => KasKecilModel(id: id, kodePt: kodePt, nosbbKasKecil: nosbbKasKecil, namasbbKaskecil: namasbbKaskecil, nosbbKasBon: nosbbKasBon, namasbbKasbon: namasbbKasbon, createddate: createddate);

  KasKecilModel copyWith({int? id, String? kodePt, String? nosbbKasKecil, String? namasbbKaskecil, String? nosbbKasBon, String? namasbbKasbon, String? createddate}) => KasKecilModel(
        id: id ?? this.id,
        kodePt: kodePt ?? this.kodePt,
        nosbbKasKecil: nosbbKasKecil ?? this.nosbbKasKecil,
        namasbbKaskecil: namasbbKaskecil ?? this.namasbbKaskecil,
        nosbbKasBon: nosbbKasBon ?? this.nosbbKasBon,
        namasbbKasbon: namasbbKasbon ?? this.namasbbKasbon,
        createddate: createddate ?? this.createddate,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is KasKecilModel && id == other.id && kodePt == other.kodePt && nosbbKasKecil == other.nosbbKasKecil && namasbbKaskecil == other.namasbbKaskecil && nosbbKasBon == other.nosbbKasBon && namasbbKasbon == other.namasbbKasbon && createddate == other.createddate;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ nosbbKasKecil.hashCode ^ namasbbKaskecil.hashCode ^ nosbbKasBon.hashCode ^ namasbbKasbon.hashCode ^ createddate.hashCode;
}

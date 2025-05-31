import 'package:flutter/foundation.dart';

@immutable
class ClosingEomSetupModel {
  const ClosingEomSetupModel({
    required this.id,
    required this.kodePt,
    required this.createddate,
    required this.bulan,
    required this.number,
    required this.isDeleted,
  });

  final int id;
  final String kodePt;
  final String createddate;
  final String bulan;
  final String number;
  final String isDeleted;

  factory ClosingEomSetupModel.fromJson(Map<String, dynamic> json) => ClosingEomSetupModel(id: json['id'] as int, kodePt: json['kode_pt'].toString(), createddate: json['createddate'].toString(), bulan: json['bulan'].toString(), number: json['number'].toString(), isDeleted: json['is_deleted'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_pt': kodePt,
        'createddate': createddate,
        'bulan': bulan,
        'number': number,
        'is_deleted': isDeleted
      };

  ClosingEomSetupModel clone() => ClosingEomSetupModel(id: id, kodePt: kodePt, createddate: createddate, bulan: bulan, number: number, isDeleted: isDeleted);

  ClosingEomSetupModel copyWith({int? id, String? kodePt, String? createddate, String? bulan, String? number, String? isDeleted}) => ClosingEomSetupModel(
        id: id ?? this.id,
        kodePt: kodePt ?? this.kodePt,
        createddate: createddate ?? this.createddate,
        bulan: bulan ?? this.bulan,
        number: number ?? this.number,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClosingEomSetupModel && id == other.id && kodePt == other.kodePt && createddate == other.createddate && bulan == other.bulan && number == other.number && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ createddate.hashCode ^ bulan.hashCode ^ number.hashCode ^ isDeleted.hashCode;
}

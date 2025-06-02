import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class GlViewModel {

  const GlViewModel({
    required this.group,
    required this.item,
  });

  final String group;
  final List<NeracaModel> item;

  factory GlViewModel.fromJson(Map<String,dynamic> json) => GlViewModel(
    group: json['group'].toString(),
    item: (json['item'] as List? ?? []).map((e) => NeracaModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'group': group,
    'item': item.map((e) => e.toJson()).toList()
  };

  GlViewModel clone() => GlViewModel(
    group: group,
    item: item.map((e) => e.clone()).toList()
  );


  GlViewModel copyWith({
    String? group,
    List<NeracaModel>? item
  }) => GlViewModel(
    group: group ?? this.group,
    item: item ?? this.item,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GlViewModel && group == other.group && item == other.item;

  @override
  int get hashCode => group.hashCode ^ item.hashCode;
}

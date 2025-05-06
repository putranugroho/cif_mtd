import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TerminalNotifier extends ChangeNotifier {
  final BuildContext context;

  TerminalNotifier({required this.context}) {}
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/data/model/statement_line.dart';

@immutable
class Statement {
  const Statement({
    required this.lines,
    required this.deductions,
  });

  final List<StatementLine> lines;
  final List<Deduction> deductions;

  Map<String, dynamic> toMap() {
    return {
      'lines': lines.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Statement(lines: $lines)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Statement && listEquals(other.lines, lines);
  }

  @override
  int get hashCode => lines.hashCode;
}

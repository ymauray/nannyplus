// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/statement_line.dart';
import 'package:nannyplus/utils/types.dart';

@immutable
class Statement {
  const Statement({
    required this.lines,
  });
  factory Statement.fromJson(String source) =>
      Statement.fromMap(json.decode(source));

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      lines: List<StatementLine>.from(
        map['lines']?.map(
          (Json x) => StatementLine.fromMap(x),
        ),
      ),
    );
  }
  final List<StatementLine> lines;

  Statement copyWith({
    List<StatementLine>? lines,
  }) {
    return Statement(
      lines: lines ?? this.lines,
    );
  }

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

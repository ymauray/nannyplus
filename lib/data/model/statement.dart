import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/statement_line.dart';

class Statement {
  List<StatementLine> lines;
  Statement({
    required this.lines,
  });

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

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      lines: List<StatementLine>.from(map['lines']?.map(
        (x) => StatementLine.fromMap(x),
      )),
    );
  }

  String toJson() => json.encode(toMap());

  factory Statement.fromJson(String source) =>
      Statement.fromMap(json.decode(source));

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

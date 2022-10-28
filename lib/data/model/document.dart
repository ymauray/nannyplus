import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class Document {
  final int id;
  final int childId;
  final String label;
  final String path;
  const Document({
    required this.id,
    required this.childId,
    required this.label,
    required this.path,
  });

  Document copyWith({
    int? id,
    int? childId,
    String? label,
    String? path,
  }) {
    return Document(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      label: label ?? this.label,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'label': label,
      'path': path,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id']?.toInt() ?? 0,
      childId: map['childId']?.toInt() ?? 0,
      label: map['label'] ?? '',
      path: map['path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Document(id: $id, childId: $childId, label: $label, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Document &&
        other.id == id &&
        other.childId == childId &&
        other.label == label &&
        other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^ childId.hashCode ^ label.hashCode ^ path.hashCode;
  }
}

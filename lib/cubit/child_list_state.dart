// ignore_for_file: public_member_api_docs, sort_constructors_first

// ---------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service_info.dart';

@immutable
abstract class ChildListState {
  const ChildListState();
}

// ---------------------------------------------------------------------------

class ChildListInitial extends ChildListState {
  const ChildListInitial();
}

// ---------------------------------------------------------------------------

class ChildListLoaded extends ChildListState {
  const ChildListLoaded(
    this.children,
    this.pendingTotal,
    this.servicesInfo, {
    this.showArchived = false,
    this.showOnboarding = false,
  });

  final List<Child> children;
  final double pendingTotal;

  final Map<int, ServiceInfo> servicesInfo;
  final bool showArchived;
  final bool showOnboarding;

  double get pendingInvoice => servicesInfo.values.fold(
        0,
        (previousValue, element) => previousValue + element.pendingInvoice,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildListLoaded &&
        listEquals(other.children, children) &&
        other.pendingTotal == pendingTotal &&
        mapEquals(other.servicesInfo, servicesInfo) &&
        other.showArchived == showArchived &&
        other.showOnboarding == showOnboarding;
  }

  @override
  int get hashCode =>
      children.hashCode ^
      pendingTotal.hashCode ^
      servicesInfo.hashCode ^
      showArchived.hashCode ^
      showOnboarding.hashCode;
}

// ---------------------------------------------------------------------------

class ChildListError extends ChildListState {
  const ChildListError(this.message);
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// ---------------------------------------------------------------------------

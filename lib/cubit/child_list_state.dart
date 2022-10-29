part of 'child_list_cubit.dart';

// ---------------------------------------------------------------------------

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
    @Deprecated('Use servicesInfo instead') this.pendingTotalPerChild,
    @Deprecated('Use servicesInfo instead') this.undeletableChildren,
    this.servicesInfo, {
    this.showArchived = false,
    this.showOnboarding = false,
  });

  final List<Child> children;
  final double pendingTotal;

  @Deprecated('Use servicesInfo instead')
  final Map<int, double> pendingTotalPerChild;

  @Deprecated('Use servicesInfo instead')
  final List<int> undeletableChildren;

  final Map<int, ServiceInfo> servicesInfo;
  final bool showArchived;
  final bool showOnboarding;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildListLoaded &&
        listEquals(other.children, children) &&
        other.pendingTotal == pendingTotal &&
        mapEquals(other.pendingTotalPerChild, pendingTotalPerChild) &&
        listEquals(other.undeletableChildren, undeletableChildren) &&
        mapEquals(other.servicesInfo, servicesInfo) &&
        other.showArchived == showArchived &&
        other.showOnboarding == showOnboarding;
  }

  @override
  int get hashCode {
    return children.hashCode ^
        pendingTotal.hashCode ^
        pendingTotalPerChild.hashCode ^
        undeletableChildren.hashCode ^
        servicesInfo.hashCode ^
        showArchived.hashCode ^
        showOnboarding.hashCode;
  }
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

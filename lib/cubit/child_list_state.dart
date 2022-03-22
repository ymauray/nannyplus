part of 'child_list_cubit.dart';

// ---------------------------------------------------------------------------

@immutable
abstract class ChildListState {
  const ChildListState();
  bool get showArchivedItems;
}

// ---------------------------------------------------------------------------

class ChildListInitial extends ChildListState {
  const ChildListInitial();

  @override
  bool get showArchivedItems => false;
}

// ---------------------------------------------------------------------------

class ChildListLoaded extends ChildListState {
  final List<Child> children;
  final double pendingTotal;
  final Map<int, double> pendingTotalPerChild;
  final bool showArchived;

  const ChildListLoaded(
    this.children,
    this.pendingTotal,
    this.pendingTotalPerChild, {
    this.showArchived = false,
  });

  @override
  bool get showArchivedItems => showArchived;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildListLoaded &&
        listEquals(other.children, children) &&
        other.pendingTotal == pendingTotal &&
        mapEquals(other.pendingTotalPerChild, pendingTotalPerChild) &&
        other.showArchived == showArchived;
  }

  @override
  int get hashCode {
    return children.hashCode ^
        pendingTotal.hashCode ^
        pendingTotalPerChild.hashCode ^
        showArchived.hashCode;
  }
}

// ---------------------------------------------------------------------------

class ChildListError extends ChildListState {
  final String message;
  const ChildListError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  bool get showArchivedItems => false;
}

// ---------------------------------------------------------------------------
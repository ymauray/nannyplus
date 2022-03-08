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
  final List<Child> children;
  const ChildListLoaded(this.children);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildListLoaded && listEquals(other.children, children);
  }

  @override
  int get hashCode => children.hashCode;
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
}

// ---------------------------------------------------------------------------
// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.servicesInfo, {
    this.showArchived = false,
    this.showOnboarding = false,
  });

  final List<Child> children;
  final double pendingTotal;

  final Map<int, ServiceInfo> servicesInfo;
  final bool showArchived;
  final bool showOnboarding;
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

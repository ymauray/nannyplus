part of 'child_info_cubit.dart';

@immutable
abstract class ChildInfoState {
  const ChildInfoState();
}

class ChildInfoInitial extends ChildInfoState {
  const ChildInfoInitial();
}

class ChildInfoLoaded extends ChildInfoState {
  const ChildInfoLoaded(this.child);

  final Child child;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildInfoLoaded && other.child == child;
  }

  @override
  int get hashCode => child.hashCode;
}

class ChildInfoError extends ChildInfoState {
  const ChildInfoError(this.message);
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildInfoError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

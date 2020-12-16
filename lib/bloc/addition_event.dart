part of 'addition_bloc.dart';

// ignore_for_file: non_constant_identifier_names

abstract class AdditionEvent extends Equatable {
  const AdditionEvent();

  @override
  List<Object> get props => [];
}

class AdditionRefreshList extends AdditionEvent {
  final int object_id;

  AdditionRefreshList(this.object_id);

  @override
  List<Object> get props => [object_id];
}

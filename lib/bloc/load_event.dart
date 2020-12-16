part of 'load_bloc.dart';

abstract class LoadEvent extends Equatable {
  const LoadEvent();

  @override
  List<Object> get props => [];
}

class Loading extends LoadEvent {}

class Complete extends LoadEvent {}

class Failure extends LoadEvent {}

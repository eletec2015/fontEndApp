part of 'load_bloc.dart';

abstract class LoadState extends Equatable {
  const LoadState();

  @override
  List<Object> get props => [];
}

class LoadInitial extends LoadState {}

class LoadingState extends LoadState {}

class CompleteState extends LoadState {}

class FailureState extends LoadState {}

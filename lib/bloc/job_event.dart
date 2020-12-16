part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class RefreshJobList extends JobEvent {}

class LoadJobList extends JobEvent {}

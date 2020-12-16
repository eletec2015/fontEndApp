part of 'job_bloc.dart';

class JobState extends Equatable {
  final List<Job> list;
  final int pageNo;
  final int pageSize;
  final int totalCount;

  const JobState({this.list, this.pageNo, this.pageSize, this.totalCount});

  factory JobState.initial() =>
      JobState(list: List<Job>(), pageNo: 1, pageSize: 10, totalCount: 0);

  JobState copyWith(
          {List<Job> list, int pageNo, int pageSize, int totalCount}) =>
      JobState(
          list: list ?? this.list,
          pageNo: pageNo ?? this.pageNo,
          pageSize: pageSize ?? this.pageSize,
          totalCount: totalCount ?? this.totalCount);

  @override
  List<Object> get props => [list, pageNo, pageSize];
}

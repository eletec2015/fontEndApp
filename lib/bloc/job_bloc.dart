import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookservice/apis/client.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobState.initial());

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Stream<JobState> mapEventToState(
    JobEvent event,
  ) async* {
    if (event is RefreshJobList) {
      yield await RestService.instance.getJobs(query: {
        'pageNo': 1,
        'pageSize': state.pageSize,
        'sorter': '-id'
      }).then<JobState>((value) {
        refreshController.refreshCompleted();
        return state.copyWith(
            list: value.data ?? [], pageNo: 2, totalCount: value.totalCount);
      }).catchError((onError) {
        refreshController.refreshFailed();
        return state.copyWith(list: [], pageNo: 1, totalCount: 0);
      });
    }

    if (event is LoadJobList) {
      if (state.list.length < state.totalCount) {
        yield await RestService.instance.getJobs(query: {
          'pageNo': state.pageNo,
          'pageSize': state.pageSize,
          'sorter': '-id'
        }).then<JobState>((value) {
          refreshController.loadComplete();
          return state.copyWith(
              list: state.list + value.data,
              pageNo: state.pageNo + 1,
              totalCount: value.totalCount);
        }).catchError((onError) {
          refreshController.refreshFailed();
          return state;
        });
      } else {
        refreshController.loadComplete();
      }
    }
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}

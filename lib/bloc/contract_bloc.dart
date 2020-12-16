import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookservice/apis/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final BuildContext context;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  ContractBloc(this.context) : super(ContractState.initial());

  @override
  Stream<ContractState> mapEventToState(
    ContractEvent event,
  ) async* {
    if (event is ContractRefreshList) {
      yield await RestService.instance
          .getContracts(query: {'sorter': '-id'}).then<ContractState>((value) {
        refreshController.refreshCompleted();
        return state.copyWith(list: value ?? []);
      }).catchError((onError) {
        refreshController.refreshFailed();
        return state.copyWith(list: []);
      });
    }
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}

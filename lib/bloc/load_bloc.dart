import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'load_event.dart';
part 'load_state.dart';

class LoadBloc extends Bloc<LoadEvent, LoadState> {
  LoadBloc() : super(LoadInitial());

  @override
  Stream<LoadState> mapEventToState(
    LoadEvent event,
  ) async* {
    if (event is Loading) {
      yield LoadingState();
    }

    if (event is Complete) {
      yield CompleteState();
    }

    if (event is Failure) {
      yield FailureState();
    }
  }
}

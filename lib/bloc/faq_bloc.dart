import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final BuildContext context;

  FaqBloc(this.context)
      : super(FaqState(Localization.of(context)
            .faq
            .map((e) => ExpansionItem(
                headerValue: e.title,
                expandedValue: e.subTtitle,
                isExpanded: false))
            .toList()));

  @override
  Stream<FaqState> mapEventToState(
    FaqEvent event,
  ) async* {}
}

import 'dart:io';

import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/apis/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'addition_event.dart';
part 'addition_state.dart';

// ignore_for_file: non_constant_identifier_names

class AdditionBloc extends Bloc<AdditionEvent, AdditionState> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  AdditionBloc() : super(AdditionState.initial());

  @override
  Stream<AdditionState> mapEventToState(
    AdditionEvent event,
  ) async* {
    if (event is AdditionRefreshList) {
      yield await RestService.instance.getImages(query: {
        'object_id': event.object_id,
        'content_type': 'order',
        'sorter': '-id'
      }).then<AdditionState>((value) {
        refreshController.refreshCompleted();
        return state.copyWith(list: value ?? []);
      }).catchError((onError) {
        refreshController.refreshFailed();
        return state.copyWith(list: []);

      });
    }
  }
}

// ignore_for_file: close_sinks
class AdditionFormBloc extends FormBloc<String, String> {
  TextFieldBloc tag = TextFieldBloc();
  InputFieldBloc<File, Object> image = InputFieldBloc<File, Object>();

  final int postId;
  final BuildContext context;

  AdditionFormBloc(this.context, this.postId) {
    addFieldBlocs(fieldBlocs: [tag, image]);
    addValidators();
  }

  void addValidators() {
    image.addValidators(
        [FileValidator(errorText: Localization.of(context).requiredString)]);
  }

  void addErrors(Map<String, dynamic> errors) {
    if (errors == null) {
      return;
    }

    tag.addFieldError(errors['tag']);
    image.addFieldError(errors['image'] ?? errors['non_field_errors']);
  }

  @override
  void onSubmitting() {
    RestService.instance
        .postImage(image.value, tag.value, 'order', postId)
        .then((value) {
      emitSuccess(canSubmitAgain: true);
    }).catchError((onError) {
      emitFailure();
      addErrors(onError?.response?.data);
    });
  }
}

class FileValidator extends FieldValidator<File> {
  FileValidator({@required String errorText}) : super(errorText);

  @override
  // ignore: override_on_non_overriding_member
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(File value) {
    return value != null;
  }

  @override
  String call(File value) {
    return isValid(value) ? null : errorText;
  }
}

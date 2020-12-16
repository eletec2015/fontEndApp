import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:bookservice/apis/client.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: close_sinks

class UserBloc extends Bloc<UserEvent, UserState> {
  final BuildContext context;

  UserBloc(this.context) : super(UserState(isLoading: false));

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UploadUserPhoto) {
      AppBloc appBloc = BlocProvider.of<AppBloc>(context);

      yield UserState(isLoading: true);

      yield await RestService.instance
          .uploadPhoto('${appBloc.state.user.id}', event.file)
          .then((user) {
        appBloc.add(UpdateAppUser(user));
        return UserState(isLoading: false);
      }).catchError((onError) {
        return UserState(isLoading: false);
      });
    }
  }
}

class UserFormBloc extends FormBloc<String, String> {
  final TextFieldBloc field = TextFieldBloc();

  final BuildContext context;

  UserFormBloc(this.context) {
    addFieldBlocs(fieldBlocs: [field]);
    addValidators();
  }

  void addErrors(Map<String, dynamic> errors) {
    if (errors == null) {
      return;
    }

    field.addFieldError(errors['first_name'] ?? errors['non_field_errors']);
  }

  void addValidators() {}

  @override
  Stream<FormBlocState<String, String>> mapEventToState(FormBlocEvent event) {
    return super.mapEventToState(event);
  }

  @override
  void onSubmitting() {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    String fieldName = RouteData.of(context).pathParams['field'].value;

    if (fieldName != 'email') {
      RestService.instance.updateUser(
          '${appBloc.state.user.id}', {'$fieldName': field.value}).then((user) {
        return RestService.instance.getInfo();
      }).then((user) {
        appBloc.add(UpdateAppUser(user));
        emitSuccess(canSubmitAgain: true);
      }).catchError((onError) {
        emitFailure();
        addErrors(onError?.response?.data);
      });
    } else {
      RestService.instance.emailGenerate({'email': field.value}).then((value) {
        return RestService.instance.getInfo();
      }).then((user) {
        appBloc.add(UpdateAppUser(user));
        emitSuccess(canSubmitAgain: true);
      }).catchError((onError) {
        emitFailure();
        addErrors(onError?.response?.data);
      });
    }
  }
}

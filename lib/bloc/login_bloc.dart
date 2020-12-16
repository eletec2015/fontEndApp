import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/apis/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

// ignore_for_file: close_sinks

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  StreamSubscription<int> controller;

  LoginBloc() : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UpdateStep) {
      yield state.copyWith(step: event.step);
    }

    if (event is LoginStartTime) {
      controller?.cancel();
      controller = RangeStream(60, 0)
          .interval(Duration(seconds: 1))
          .listen((i) => add(LoginUpdateTime(i)));

      yield state.copyWith(leftTime: 60);
    }

    if (event is LoginUpdateTime) {
      yield state.copyWith(leftTime: event.leftTime);
    }

    if (event is LoginStopTime) {
      controller?.cancel();
      yield state.copyWith(leftTime: 0);
    }
  }

  @override
  Future<void> close() {
    controller?.cancel();

    return super.close();
  }
}

class SendFormBloc extends FormBloc<String, String> {
  final TextFieldBloc phoneNumber = TextFieldBloc();
  final TextFieldBloc dialCode = TextFieldBloc();

  final BuildContext context;

  SendFormBloc(this.context) {
    addFieldBlocs(fieldBlocs: [phoneNumber, dialCode]);
    addValidators();
  }

  void addErrors(Map<String, dynamic> errors) {
    if (errors == null) {
      return;
    }

    phoneNumber
        .addFieldError(errors['phone_number'] ?? errors['non_field_errors']);
    dialCode.addFieldError(errors['dialCode'] ?? errors['non_field_errors']);
  }

  void addValidators() {
    phoneNumber.addValidators([
      RequiredValidator(errorText: Localization.of(context).requiredString)
    ]);
    dialCode.addValidators([
      RequiredValidator(errorText: Localization.of(context).requiredString)
    ]);
  }

  @override
  Stream<FormBlocState<String, String>> mapEventToState(FormBlocEvent event) {
    return super.mapEventToState(event);
  }

  @override
  void onSubmitting() {
    RestService.instance.phoneGenerate(
        {'phone_number': dialCode.value + phoneNumber.value}).then((value) {
      emitSuccess(canSubmitAgain: true);
    }).catchError((onError) {
      emitFailure();
      addErrors(onError?.response?.data);
    });
  }
}

class VerifyFormBloc extends FormBloc<String, String> {
  final TextFieldBloc otp = TextFieldBloc();

  final BuildContext context;

  VerifyFormBloc(this.context) {
    addFieldBlocs(fieldBlocs: [otp]);
    addValidators();
  }

  void addErrors(Map<String, dynamic> errors) {
    if (errors == null) {
      return;
    }
    otp.addFieldError(errors['otp'] ?? errors['non_field_errors']);
  }

  void addValidators() {
    otp.addValidators([
      RequiredValidator(errorText: Localization.of(context).requiredString)
    ]);
  }

  @override
  void onSubmitting() {
    SendFormBloc sendFormBloc = BlocProvider.of<SendFormBloc>(context);

    RestService.instance.phoneValidate({
      'phone_number':
          sendFormBloc.dialCode.value + sendFormBloc.phoneNumber.value,
      'otp': otp.value
    }).then((value) {
      return CacheService.instance.setToken(value.token);
    }).then((value) {
      emitSuccess(canSubmitAgain: true);
    }).catchError((onError) {
      emitFailure();
      addErrors(onError?.response?.data);
    });
  }
}

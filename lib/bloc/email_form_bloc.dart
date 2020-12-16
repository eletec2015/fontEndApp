import 'package:auto_route/auto_route.dart';
import 'package:bookservice/apis/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'app_bloc.dart';

// ignore_for_file: close_sinks

class EmailFormBloc extends FormBloc<String, String> {
  final TextFieldBloc field = TextFieldBloc();

  final BuildContext context;

  EmailFormBloc(this.context) {
    addFieldBlocs(fieldBlocs: [field]);
  }

  void addErrors(Map<String, dynamic> errors) {
    if (errors == null) {
      return;
    }

    field.addFieldError(errors['code'] ?? errors['non_field_errors']);
  }

  @override
  void onSubmitting() {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    String email = RouteData.of(context).pathParams['email'].value;

    RestService.instance
        .emailValidate({'email': email, 'code': field.value}).then((value) {
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

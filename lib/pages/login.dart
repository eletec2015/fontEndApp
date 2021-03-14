import 'package:animate_do/animate_do.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/bloc/login_bloc.dart';
import 'package:bookservice/views/dialog.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore_for_file: close_sinks

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Builder(
        builder: (context) {
          return BlocProvider<SendFormBloc>(
            create: (_) => SendFormBloc(context),
            child: Builder(
              builder: (context) {
                return BlocProvider<VerifyFormBloc>(
                    create: (_) => VerifyFormBloc(context), child: LoginView());
              },
            ),
          );
        },
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 50),
            SizedBox.fromSize(

              size: Size.fromHeight(MediaQuery.of(context).size.height / 9),
              child: Image.asset(
                "assets/images/eletec_logoing.png",
                width: 100,
                height: 100,
                alignment: Alignment.center,
              ),
            ),
            SizedBox.fromSize(

              size: Size.fromHeight(MediaQuery.of(context).size.height / 9),

            ),
            Flexible(child:
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state.step == LogInStep.SEND) {
                return FadeInUp(
                    child: SendView(), duration: Duration(milliseconds: 500));
              }

              if (state.step == LogInStep.VERIFY) {
                return FadeInUp(
                    child: VerifyView(), duration: Duration(milliseconds: 500));
              }

              return Container();
            }))
          ],
        ));
  }
}

class SendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SendFormBloc formBloc = BlocProvider.of<SendFormBloc>(context);
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    final Widget buidlPhoneField = TextFieldBlocBuilder(
        textFieldBloc: formBloc.phoneNumber,
        onSubmitted: (value) {
          formBloc.submit();
        },
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            labelText: Localization.of(context).phoneNumber,
            prefixIcon: Container(
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<TextFieldBloc, TextFieldBlocState>(
                  cubit: formBloc.dialCode,
                  builder: (_, __) {
                    return CountryCodePicker(
                      onInit: (value) {
                        formBloc.dialCode.updateValue(value.dialCode);
                      },
                      onChanged: (value) {
                        formBloc.dialCode.updateValue(value.dialCode);
                      },
                      initialSelection: 'AE',
                      favorite: ['+971', 'AE'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    );
                  },
                )),
            errorMaxLines: 6,
            border: OutlineInputBorder(),
            suffixIcon: const Icon(Icons.phone)));

    final Widget buildSubmit = BlocBuilder<FormBloc, dynamic>(
      cubit: formBloc,
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
                child: Text(BlocProvider.of<LoginBloc>(context).state.leftTime >
                        0
                    ? '${BlocProvider.of<LoginBloc>(context).state.leftTime}'
                    : Localization.of(context).send),
                onPressed: state.isValid() &&
                        BlocProvider.of<LoginBloc>(context).state.leftTime == 0
                    ? () {
                        formBloc.submit();
                      }
                    : null));
      },
    );

    return FormBlocListener<SendFormBloc, String, String>(
        onFailure: (context, state) {
          LoadingDialog.hide(context);
          loginBloc.add(LoginStopTime());
        },
        onSuccess: (context, state) {
          LoadingDialog.hide(context);
          loginBloc.add(UpdateStep(LogInStep.VERIFY));
        },
        onSubmitting: (context, state) {
          LoadingDialog.show(context);
          loginBloc.add(LoginStartTime());
        },
        child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              children: <Widget>[
                Text(Localization.of(context).login,style: TextStyle(color: Theme.of(context).primaryColor),),
                Text(Localization.of(context).tocontinue,style: TextStyle(color: Theme.of(context).primaryColor),),
                SizedBox(height: 60,),
                buidlPhoneField,
                buildSubmit],
            )));
  }
}

class VerifyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VerifyFormBloc formBloc = BlocProvider.of<VerifyFormBloc>(context);
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    final Widget buildSubmit = BlocBuilder<FormBloc, dynamic>(
      cubit: formBloc,
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RaisedButton(
                child: Text(Localization.of(context).verify),
                onPressed: state.isValid()
                    ? () {
                        formBloc.submit();
                      }
                    : null));
      },
    );

    return FormBlocListener<VerifyFormBloc, String, String>(
        onFailure: (context, state) {
          LoadingDialog.hide(context);
        },
        onSuccess: (context, state) {
          LoadingDialog.hide(context);
          BlocProvider.of<AppBloc>(context).add(AuthenticationStart());
        },
        onSubmitting: (context, state) {
          LoadingDialog.show(context);
        },
        child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              children: <Widget>[
               Text(Localization.of(context).otp),
                Text(Localization.of(context).phoneverification),
                SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                  length: 4,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    activeColor: Theme.of(context).primaryColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: false,
                  autoDisposeControllers: true,
                  onCompleted: (value) {
                    formBloc.submit();
                  },
                  onChanged: (value) {
                    formBloc.otp.updateValue(value);
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
                BlocBuilder<TextFieldBloc, TextFieldBlocState>(
                    cubit: formBloc.otp,
                    builder: (context, state) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          state.error ?? '',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: Localization.of(context).receiveHelp,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: Localization.of(context).reSend,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                loginBloc.add(UpdateStep(LogInStep.SEND));
                              },
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ]),
                ),
                SizedBox(
                  height: 18,
                ),
                buildSubmit
              ],
            )));
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        print("usman");
        print(state.status);
        if (state.status == AppStatus.Welcom) {
          return WelcomePage();
        }

        if (state.status == AppStatus.Authenticating) {
          return FadeIn(child: FtechUserPage());
        }

        if (state.status == AppStatus.UnAuthorizedState) {
          return FadeIn(child: LoginPage());
        }

        if (state.status == AppStatus.AuthorizedState) {
          return FadeIn(child: HomePage());
        }

        return LoginPage();
      }));
}

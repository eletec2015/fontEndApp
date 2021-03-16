import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/pages/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0xFF1d364f)
  ));
  runApp(BlocProvider<AppBloc>(
    create: (_) => AppBloc()..add(AppInitial()),
    child: EletecApp(),
  ));
}

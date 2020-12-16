import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/pages/app.dart';

void main() {
  runApp(BlocProvider<AppBloc>(
    create: (_) => AppBloc()..add(AppInitial()),
    child: EletecApp(),
  ));
}

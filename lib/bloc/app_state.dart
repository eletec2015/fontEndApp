part of 'app_bloc.dart';

enum AppStatus {
  Welcom,
  Authenticating,
  AuthorizedState,
  UnAuthorizedState,
}

class AppState extends Equatable {
  final Locale locale;
  final User user;
  final int leftTime;
  final AppStatus status;

  @override
  List<Object> get props => [locale.languageCode, user, leftTime, status];

  AppState({this.locale, this.user, this.leftTime, this.status});

  factory AppState.initial() => AppState(
      locale: Locale('en', ''),
      user: null,
      leftTime: 0,
      status: AppStatus.Welcom);

  AppState copyWith(
          {Locale locale,
          User user,
          int leftTime,
          AppStatus status,
          bool loading}) =>
      AppState(
          locale: locale ?? this.locale,
          user: user ?? this.user,
          leftTime: leftTime ?? this.leftTime,
          status: status ?? this.status);
}

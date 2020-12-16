part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppEvent {}

class WelcomStartTime extends AppEvent {}

class WelcomUpdateTime extends AppEvent {
  final int leftTime;

  WelcomUpdateTime(this.leftTime);

  @override
  List<Object> get props => [leftTime];
}

class WelcomStopTime extends AppEvent {}

class AuthenticationStart extends AppEvent {}

class SignOut extends AppEvent {}

class UpdateAppUser extends AppEvent {
  final User user;

  UpdateAppUser(this.user);
}

class SwitchLanguage extends AppEvent {
  final Locale locale;

  SwitchLanguage(this.locale);

  @override
  List<Object> get props => [locale];
}

part of 'login_bloc.dart';

enum LogInStep { SEND, VERIFY }

class LoginState extends Equatable {
  final int leftTime;
  final LogInStep step;

  LoginState({this.leftTime, this.step});

  factory LoginState.initial() => LoginState(leftTime: 0, step: LogInStep.SEND);

  LoginState copyWith({int leftTime, LogInStep step}) =>
      LoginState(leftTime: leftTime ?? this.leftTime, step: step ?? this.step);

  @override
  List<Object> get props => [leftTime, step];
}

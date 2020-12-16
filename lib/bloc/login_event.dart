part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UpdateStep extends LoginEvent {
  final LogInStep step;

  UpdateStep(this.step);

  @override
  List<Object> get props => [step];
}

class LoginStartTime extends LoginEvent {}

class LoginUpdateTime extends LoginEvent {
  final int leftTime;

  LoginUpdateTime(this.leftTime);

  @override
  List<Object> get props => [leftTime];
}

class LoginStopTime extends LoginEvent {}

// class LoginInitial extends LoginEvent {}

// class LoginInput extends LoginEvent {
//   final String phoneNumber;
//   final String otp;
//   final String dialCode;

//   LoginInput({this.phoneNumber, this.otp, this.dialCode});

//   @override
//   List<Object> get props => [phoneNumber, otp];
// }

// class SignIn extends LoginEvent {}

// class SendSms extends LoginEvent {}

// class Back extends LoginEvent {}

// class Timer extends LoginEvent {
//   final int time;

//   Timer(this.time);

//   @override
//   List<Object> get props => [time];
// }

part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLoading;

  const UserState({this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

part of 'contract_bloc.dart';

class ContractState extends Equatable {
  final List<Contract> list;

  const ContractState({this.list});

  factory ContractState.initial() => ContractState(list: List<Contract>());

  ContractState copyWith({List<Contract> list}) =>
      ContractState(list: list ?? this.list);

  @override
  List<Object> get props => [list];
}

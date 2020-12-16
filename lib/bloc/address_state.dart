part of 'address_bloc.dart';

class AddressState extends Equatable {
  final List<Address> list;

  const AddressState({this.list});

  factory AddressState.initial() => AddressState(list: List<Address>());

  AddressState copyWith({List<Address> list, bool isLoading}) =>
      AddressState(list: list ?? this.list);

  @override
  List<Object> get props => [list];
}

abstract class AddressPostState extends Equatable {
  List<Object> get props => [];
}

class AddressFormState extends AddressPostState {}

class AddressMapState extends AddressPostState {}

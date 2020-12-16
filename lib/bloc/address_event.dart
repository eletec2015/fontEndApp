part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressRefreshList extends AddressEvent {}

class AddressFormEvent extends AddressEvent {}

class AddressMapEvent extends AddressEvent {}

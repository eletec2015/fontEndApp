part of 'client.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: must_be_immutable

@JsonSerializable()
class Visit extends Equatable {
  int service;
  int count;

  @override
  List<Object> get props => [service, count];

  static Visit fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
  Map<String, dynamic> toJson() => _$VisitToJson(this);
}

@JsonSerializable()
class Contract extends Equatable {
  int id;
  String contractID;
  int option;
  String issue_date;
  String expiry_date;
  String address;
  String remark;
  List<Visit> visits;

  static Contract fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);

  @override
  List<Object> get props => [
        id,
        contractID,
        option,
        issue_date,
        expiry_date,
        address,
        remark,
        visits
      ];
}

@JsonSerializable()
class ContractList extends Equatable {
  int totalCount;
  int pageNo;

  List<Contract> data;

  static ContractList fromJson(Map<String, dynamic> json) =>
      _$ContractListFromJson(json);
  Map<String, dynamic> toJson() => _$ContractListToJson(this);

  @override
  List<Object> get props => [totalCount, pageNo];
}

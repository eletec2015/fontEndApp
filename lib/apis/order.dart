part of 'client.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: must_be_immutable

@JsonSerializable()
class Order extends Equatable {
  int id;
  User user;
  int user_id;
  Contract contract;
  int contract_id;
  String orderID;
  List<SourceImage> images;
  List<Job> jobs;
  List<Comment> comments;
  int status;
  int service;
  int main_info;
  int sub_info;
  String from_date;
  String to_date;
  String code;
  String address;
  double lat;
  double lng;
  String create_at;
  String change_at;
  bool deleted;

  Order(
      {this.id,
      this.user,
      this.user_id,
      this.contract,
      this.contract_id,
      this.orderID,
      this.images,
      this.jobs,
      this.comments,
      this.status = 0,
      this.service = 0,
      this.main_info = 0,
      this.sub_info = 0,
      this.from_date,
      this.to_date,
      this.code,
      this.address,
      this.lat,
      this.lng,
      this.create_at,
      this.change_at,
      this.deleted});

  static Order fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  List<Object> get props => [
        id,
        user,
        user_id,
        contract,
        contract_id,
        orderID,
        images,
        jobs,
        comments,
        status,
        service,
        main_info,
        sub_info,
        from_date,
        to_date,
        code,
        address,
        lat,
        lng,
        create_at,
        change_at,
        deleted
      ];
}

@JsonSerializable()
class OrderList extends Equatable {

  int totalCount;
  int pageNo;
  List<Order> data;

  static OrderList fromJson(Map<String, dynamic> json) =>
      _$OrderListFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListToJson(this);

  @override
  List<Object> get props => [totalCount, pageNo];
}

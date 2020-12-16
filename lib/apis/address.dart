part of 'client.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: must_be_immutable

@JsonSerializable()
class Address extends Equatable {
  int id;
  bool defAddr;
  bool onMap;
  int model;
  int style;
  String city;
  String community;
  String street;
  String building;
  String roomNo;
  double lat;
  double lng;
  String address;
  int user_id;

  Address(
      {this.id,
      this.defAddr,
      this.onMap,
      this.model,
      this.style,
      this.city,
      this.community,
      this.street,
      this.building,
      this.roomNo,
      this.lat,
      this.lng,
      this.address,
      this.user_id});

  Address copyWidth(
          {int id,
          bool defAddr,
          bool onMap,
          int model,
          int style,
          String city,
          String community,
          String street,
          String building,
          String roomNo,
          double lat,
          double lng,
          String address,
          int user_id}) =>
      Address(
          id: id ?? this.id,
          defAddr: defAddr ?? this.defAddr,
          onMap: onMap ?? this.onMap,
          model: model ?? this.model,
          style: style ?? this.style,
          city: city ?? this.city,
          community: community ?? this.community,
          street: street ?? this.street,
          building: building ?? this.building,
          roomNo: roomNo ?? this.roomNo,
          lat: lat ?? this.lat,
          lng: lng ?? this.lng,
          address: address ?? this.address,
          user_id: user_id ?? this.user_id);

  static Address fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String get toTitle => onMap
      ? address
      : '${roomNo + ' / ' + building + ' / ' + street + ' / ' + community + ' / ' + city}';

  @override
  List<Object> get props => [
        id,
        defAddr,
        onMap,
        model,
        style,
        city,
        community,
        street,
        building,
        roomNo,
        lat,
        lng,
        address,
        user_id
      ];
}

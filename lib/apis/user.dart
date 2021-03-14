part of 'client.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: must_be_immutable

@JsonSerializable()
class User extends Equatable {
  int id;
  String username;
  String name;
  String first_name;
  String last_name;
  bool is_staff;
  bool is_active;
  bool is_superuser;
  EmailAddress email;

  int role;
  Map<String, String> photo;

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        id,
        username,
        first_name,
        last_name,
        is_staff,
        is_active,
        is_superuser,
        role,
        photo,
        email,
      ];
}

class ProfileDetails {
  int id;
  String first_name;
  String last_name;
  String email;
  int gender;
  String phone_number;

  ProfileDetails({this.id, this.first_name, this.last_name,this.email, this.gender, this.phone_number});

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      phone_number: json['phone_number'],
    );
  }
}




@JsonSerializable()
class EmailAddress extends Equatable {
  String email;
  bool verified;

  static EmailAddress fromJson(Map<String, dynamic> json) =>
      _$EmailAddressFromJson(json);
  Map<String, dynamic> toJson() => _$EmailAddressToJson(this);

  @override
  List<Object> get props => [email, verified];
}

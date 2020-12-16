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

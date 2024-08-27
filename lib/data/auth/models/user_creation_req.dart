// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserCreationReq {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? gender;
  String? age;
  UserCreationReq({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

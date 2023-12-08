// ignore_for_file: public_member_api_docs, sort_constructors_first
class PasswordModel {
  int? id;
  String password;
  PasswordModel({
    this.id,
    required this.password,
  });

  static PasswordModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final password = map['password'] as String;

    return PasswordModel(id: id, password: password);
  }
}

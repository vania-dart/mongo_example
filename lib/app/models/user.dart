import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  User({this.id, this.firstName, this.lastName, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}

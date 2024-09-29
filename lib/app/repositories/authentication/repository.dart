import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_example/app/models/user.dart';
import 'package:mongo_example/app/repositories/authentication/repository_abs.dart';
import 'package:mongo_example/database/mongodb/mongo_db_connection.dart';
import 'package:vania/vania.dart';

class Repository implements RepositoryAbs {
  DbCollection collection = MongoDBConnection().db.collection('users');

  @override
  Future<Response> login(Map<String, dynamic> data) async {
    Map<String, dynamic>? user = await collection.findOne({
      'email': data['email'],
    });

    if (user == null) {
      return Response.json({'message': 'Wrong credentials'}, 401);
    }

    if (!Hash().verify(data['password'], user['password'])) {
      return Response.json({'message': 'Wrong credentials'}, 401);
    }

    // Remove password field for security reasons
    user.remove('password');

    // We create a custom token because we use mongodb
    Map<String, dynamic> token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(hours: 24), customToken: true);

    return Response.json(token);
  }

  @override
  Future<Response> register(Map<String, dynamic> data) async {
    data['password'] = Hash().make(data['password']);

    // Check if email already exists
    Map<String, dynamic>? emailExists = await collection.findOne({
      'email': data['email'],
    });

    if (emailExists != null) {
      return Response.json({'message': 'Email already exists'}, 400);
    }

    // Insert new user
    await collection.insertOne(
        User(email: data['email'], password: data['password']).toJson());

    Map<String, dynamic>? user = await collection.findOne({
      'email': data['email'],
    });

    // Remove password field for security reasons
    user!.remove('password');

// We create a custom token because we use mongodb
    Map<String, dynamic> token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(hours: 24), customToken: true);

    return Response.json(token);
  }
}

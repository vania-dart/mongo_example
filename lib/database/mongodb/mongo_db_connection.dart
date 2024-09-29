import 'package:mongo_dart/mongo_dart.dart';
import 'package:vania/vania.dart';

class MongoDBConnection {
  static final MongoDBConnection _instance = MongoDBConnection._internal();
  factory MongoDBConnection() => _instance;
  MongoDBConnection._internal();

  late Db _db;

  Future<void> init() async {
    _db = await Db.create(env<String>('MONGODB_URI'));
    await _db.open();
  }

  Db get db => _db;
}

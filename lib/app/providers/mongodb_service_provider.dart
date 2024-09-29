import 'package:mongo_example/database/mongodb/mongo_db_connection.dart';
import 'package:vania/vania.dart';

class MongodbServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    await MongoDBConnection().init();
  }
}

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_example/app/http/controllers/api/authntication/auth_controller.dart';
import 'package:mongo_example/app/http/middleware/authenticate.dart';
import 'package:mongo_example/app/models/user.dart';
import 'package:mongo_example/database/mongodb/mongo_db_connection.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.group(() {
      Router.post('login', authController.login);

      Router.post('register', authController.register);
    }, prefix: 'auth', middleware: [
      Throttle(
        maxAttempts: 3,
        duration: Duration(seconds: 60),
      ),
    ]);

    Router.group(() {
      Router.get('/details', () async {
        DbCollection collection = MongoDBConnection().db.collection('users');
        Map<String, dynamic>? userResult = await collection.findOne(
          where.id(
            ObjectId.parse(
              Auth().id(),
            ),
          ),
        );
        User user = User.fromJson(userResult!);
        return Response.json(user.toJson());
      });
    }, prefix: 'user', middleware: [AuthenticateMiddleware()]);
  }
}

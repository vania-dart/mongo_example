import 'package:vania/vania.dart';
import 'package:mongo_example/route/api_route.dart';
import 'package:mongo_example/route/web.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
  }
}

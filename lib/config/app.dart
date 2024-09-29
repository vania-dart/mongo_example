import 'package:mongo_example/app/providers/mongodb_service_provider.dart';
import 'package:vania/vania.dart';
import 'package:mongo_example/app/providers/route_service_provider.dart';

import 'auth.dart';
import 'cors.dart';

Map<String, dynamic> config = {
  'name': env('APP_NAME'),
  'url': env('APP_URL'),
  'cors': cors,
  'auth': authConfig,
  'providers': <ServiceProvider>[
    RouteServiceProvider(),
    MongodbServiceProvider()
  ],
};

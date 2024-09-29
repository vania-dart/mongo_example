import 'package:vania/vania.dart';

class AuthenticateMiddleware extends Middleware {
  String? guard;
  @override
  Future handle(Request req) async {
    String? token = req.header('authorization')?.replaceFirst('Bearer ', '');
    try {
      if (guard == null) {
        await Auth().check(token ?? '', isCustomToken: true);
      } else {
        await Auth().guard(guard!).check(token ?? '', isCustomToken: true);
      }
    } catch (_) {
      abort(401, 'Invalid token');
    }
  }
}

import 'package:mongo_example/app/repositories/authentication/repository.dart';
import 'package:vania/vania.dart';

// Base form validation
void formValidation(Request request) {
  request.validate({
    'email': 'required|email',
    'password': 'required|min_length:6',
  }, {
    'email.required': 'Email is required',
    'email.email': 'Email is not valid',
    'password.required': 'Password is required',
    'password.min_length': 'Password must be at least 6 characters',
  });
}

class AuthController extends Controller {
  Future<Response> login(Request request) async {
    formValidation(request);
    return await Repository().login(request.all());
  }

  Future<Response> register(Request request) async {
    formValidation(request);
    return await Repository().register(request.all());
  }
}

final AuthController authController = AuthController();

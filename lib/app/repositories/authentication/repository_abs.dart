import 'package:vania/vania.dart';

abstract class RepositoryAbs {
  Future<Response> register(Map<String, dynamic> data);
  Future<Response> login(Map<String, dynamic> data);
}

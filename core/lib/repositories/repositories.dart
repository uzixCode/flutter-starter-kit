import 'package:core/core.dart';
import 'src/auth/data/repositories.dart';

class Repositories {
  Repositories(this.htreq) : super() {
    auth = AuthRepositories(htreq);
  }
  final Htreq htreq;
  //external repos
  late final AuthRepositories auth;

  //local repos
}

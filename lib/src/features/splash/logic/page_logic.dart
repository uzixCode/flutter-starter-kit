import 'package:core/core.dart';

class PageLogic extends PagesCubit {
  void splashing() async {
    await Future.delayed(const Duration(seconds: 3));
    locator<GoRouter>().go(PathRoutes.main.pather());
  }
}

import 'package:api/src/core/constants/consts.dart';
import 'package:api/src/core/database/database.dart';

import 'package:api/src/modules/user/user_controller.dart';

import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../data/repository/user_repository.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../services/user_service.dart';
import '../../services/user_service_impl.dart';

sealed class UserRoute {
  static Router routes(Router router) {
    GetIt.I.registerSingleton<UserRepository>(
      UserRepositoryImpl(
          database: GetIt.I.get<Database>(instanceName: Consts.mysqlInstance)),
      instanceName: Consts.userRepository,
    );

    GetIt.I.registerSingleton<UserService>(
      UserServiceImpl(
          repository:
              GetIt.I.get<UserRepository>(instanceName: Consts.userRepository)),
      instanceName: Consts.userService,
    );

    final userController = UserController(
        service: GetIt.I.get<UserService>(instanceName: Consts.userService));
    router.add('get', '/users', userController.getAll);
    router.add('get', '/user/<id>', userController.getById);
    router.add('post', '/user', userController.save);
    router.add('put', '/user/<id>', userController.update);
    router.add('delete', '/user/<id>', userController.delete);
    return router;
  }
}

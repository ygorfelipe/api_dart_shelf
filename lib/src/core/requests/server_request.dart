import 'package:api/src/modules/order/order_route.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../modules/user/user_route.dart';

class ServerRequest {
  Router load() {
    final router = Router();
    OrderRoute.routes(router);
    UserRoute.routes(router);
    return router;
  }
}

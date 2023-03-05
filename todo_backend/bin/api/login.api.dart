import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security.service.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;

  LoginApi(this._securityService);

  @override
  Handler getHandler({List<Middleware>? middleware}) {
    Router router = Router();

    router.post('/login', (Request req) async {
      return Response.ok(
        await _securityService.generateJWT('1'),
      );
    });

    return createHandler(router: router, middlewares: middleware);
  }
}

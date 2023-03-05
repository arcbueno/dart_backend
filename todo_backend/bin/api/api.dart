import 'package:shelf/shelf.dart';

import '../infra/dependecy_injector/depencedy_injector.dart';
import '../infra/security/security.service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middleware,
    isSecurityEnabled = true,
  });
  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurityEnabled = true,
  }) {
    middlewares ??= [];

    if (isSecurityEnabled) {
      SecurityService securityService =
          DependecyInjector().get<SecurityService>();

      middlewares
          .addAll([securityService.verifyJwt, securityService.authorization]);
    }

    var pipeline = Pipeline();

    middlewares.forEach((element) {
      pipeline = pipeline.addMiddleware(element);
    });

    return pipeline.addHandler(router);
  }
}

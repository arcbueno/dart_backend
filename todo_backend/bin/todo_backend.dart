import 'package:shelf/shelf.dart';

import 'api/login.api.dart';
import 'api/tasks.api.dart';
import 'infra/custom_server.dart';
import 'infra/dependecy_injector/depencedy_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security.service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/tasks.service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');
  final _di = DependecyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp(), isSingleton: true);

  SecurityService securityService = _di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(securityService).getHandler(isSecurityEnabled: false))
      .add(TasksApi(TasksService()).getHandler());

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler.handler);

  await CustomServer().initializeAsync(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'port_address'),
  );
}

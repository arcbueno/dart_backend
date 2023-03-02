import 'package:shelf/shelf.dart';

import 'api/login.api.dart';
import 'api/tasks.api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_imp.dart';
import 'services/tasks.service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');
  var cascadeHandler = Cascade()
      .add(LoginApi(SecurityServiceImp()).handler)
      .add(TasksApi(TasksService()).handler);

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

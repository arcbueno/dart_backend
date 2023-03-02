import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Server {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok('Opa');
    });

    router.get('/api/todos', (Request req) {
      return Response.ok('List of all to dos');
    });

    router.get('/api/todos/<id>', (Request req, String id) {
      return Response.ok('Details of task $id');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);
      var userName = json['name'];
      var password = json['password'];

      if (userName == 'admin' && password == 'admin') {
        var returnObj = jsonEncode({
          'token': 'token123',
        });
        return Response.ok(returnObj, headers: {
          'content-type': 'application/json',
        });
      }
      return Response.forbidden('Forbidden');
    });

    return router;
  }
}

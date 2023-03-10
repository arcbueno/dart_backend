import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/task.dart';
import '../services/generic.service.dart';
import 'api.dart';

class TasksApi extends Api {
  final GenericService<Task> _service;
  TasksApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middleware, isSecurityEnabled = true}) {
    Router router = Router();

    router.get('/tasks', (Request req) {
      List<Task> tasks = _service.findAll();
      return Response.ok(jsonEncode(tasks.map((e) => e.toMap()).toList()));
    });
    router.post('/tasks', (Request req) async {
      var body = await req.readAsString();
      _service.save(Task.fromJson(body));
      return Response(201);
    });
    router.put('/tasks/<id>', (Request req, int id) async {
      // var body = await req.readAsString();
      // _service.save(Task.fromJson(body));
      // return Response(201);
    });
    router.delete('/tasks/<id>', (Request req, int id) {
      _service.delete(id);
      return Response.ok('');
    });

    return createHandler(
      router: router,
      middlewares: middleware,
      isSecurityEnabled: isSecurityEnabled,
    );
  }
}

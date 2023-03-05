import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middleware});
  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];

    var pipeline = Pipeline();

    middlewares.forEach((element) {
      pipeline = pipeline.addMiddleware(element);
    });

    return pipeline.addHandler(router);
  }
}

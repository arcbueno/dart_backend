import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

class CustomServer {
  Future<void> initializeAsync({
    required String address,
    required int port,
    required Handler handler,
  }) async {
    print('Server initialized on http://$address:$port');
    await serve(handler, address, port);
    print('Server initated');
  }
}

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../utils/custom_env.dart';
import 'security.service.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userId) async {
    var jwt = JWT(
      {
        'iat': DateTime.now().millisecondsSinceEpoch,
        'userId': userId,
        'roles': [
          'admin',
          'user',
        ]
      },
    );

    var key = await CustomEnv.get<String>(key: 'jwt_key');
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  JWT? validateJWT(String token) {}
}

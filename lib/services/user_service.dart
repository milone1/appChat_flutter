import 'package:appchat_flutter/models/user_response.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:appchat_flutter/Global/enviroments.dart';
import 'package:appchat_flutter/models/user.dart';

class UserService {
  Future<List<User>> getUsuarios() async {
    try {
      final url = '${Enviroments.apiUrl}/users';
      final token = await AuthService.getToken;

      final resp = await http.get(Uri.parse(url),
          headers: {'content-type': 'application/json', 'x-token': token!});
      // ignore: non_constant_identifier_names
      final UserResponse = userResponseFromJson(resp.body);
      return UserResponse.user;
    } catch (e) {
      return [];
    }
  }
}

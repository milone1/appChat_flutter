import 'dart:io';

class Enviroments {
  static String apiUrl = Platform.isAndroid
      ? 'https://appchatnodejs-production.up.railway.app/api'
      : 'https://appchatnodejs-production.up.railway.app/api';

  static String socketUrl = Platform.isAndroid
      ? 'https://appchatnodejs-production.up.railway.app'
      : 'https://appchatnodejs-production.up.railway.app';
}

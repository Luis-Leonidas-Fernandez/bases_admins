import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

class Environment {

  //urls services

  
  static String apiUrl        = Platform.isAndroid ? 'http://10.0.2.2:3000/api' : 'http://http://localhost:3000/api';
  static String apiUrlWeb  = kIsWeb ? 'http://10.0.2.2:3000/'     : 'http://localhost:3000';
}

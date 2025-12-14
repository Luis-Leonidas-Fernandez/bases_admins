
import 'package:transport_dashboard/service/storage_service.dart';

class LogOutApp {

 LogOutApp._internal();

  static final LogOutApp _instance = LogOutApp._internal();
  static LogOutApp get instance => _instance;

  void finishApp() async {
    
    StorageService.prefs.remove('token');
    StorageService.prefs.remove('uid');
    StorageService.prefs.remove('nombre');
    


    
  }

}
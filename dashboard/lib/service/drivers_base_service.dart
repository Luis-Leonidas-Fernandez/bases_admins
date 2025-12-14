import 'package:transport_dashboard/api/config.dart';
import 'package:transport_dashboard/models/drivers.dart';
import 'package:transport_dashboard/service/storage_service.dart';
import 'package:flutter/foundation.dart';

class DriversAndBaseService {

  late DriversModel driversModel;
  
  // Recibe todos los conductores suscriptos a una base
  getDriversAndBase () async {

     
    final String? uid = StorageService.prefs.getString('uid');

    final String? base = StorageService.prefs.getString('base'); 

    if( uid == null && base == null) return;  
   
       final String baseAndDriversPath = '/base/drivers-from-admin/$uid/$base';     
       
       final respuesta = await ApiConfig.get(baseAndDriversPath); 
       
       final data = respuesta as Map<String, dynamic>; 
              
       final drivers = await compute(DriversModel.fromJson, data);      
       
       
       ApiConfig.configureDio(); 
       return drivers;
      
    
  }

  //Habilita a un conductor a trabajar dentro de una base

  putEnableDriver (String idDriver) async {

  
    if( idDriver.isEmpty) return;  
   
      final String enableDriverPath = '/base/enable-driver/$idDriver';   
 
       final respuesta = await ApiConfig.put(enableDriverPath); 
       
       final data = respuesta as Map<String, dynamic>; 
              
       final authResponse = await compute(DriversModel.fromJson, data);        
              
       ApiConfig.configureDio(); 
       return authResponse;
         
    
  }
}
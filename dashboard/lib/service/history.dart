import 'package:dashborad/api/config.dart';
import 'package:dashborad/models/travels.dart';
import 'package:flutter/foundation.dart';

class TravelHistoryService {

  Future<TravelModel?> getViajesDriver( String? driverId) async {
    

    if (driverId == null) return null;

    final String path = '/travel-history/driver/$driverId';

    final response = await ApiConfig.get(path);

   
        
    final data = response as Map<String, dynamic>;

    final viajesModel = await compute(TravelModel.fromJson, data);

    ApiConfig.configureDio();
    return viajesModel;
  }
}

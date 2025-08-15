import 'dart:async';

import 'package:dashborad/blocs/blocs.dart';
import 'package:dashborad/models/drivers.dart';
import 'package:dashborad/service/drivers_base_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'drivers_event.dart';
part 'drivers_state.dart';

class DriversBloc extends HydratedBloc<DriversEvent, DriversState> {

  DriversAndBaseService driverBaseService;
  AuthBloc authBloc; 
  Timer? timer;

 
  DriversBloc({required this.driverBaseService, required this.authBloc})
      : super(const DriversState()) {
    //Push Events

    //clear data
    on<OnClearStateEvent>((event, emit) => emit(const DriverInitialState()));
    // get data
    on<UpdateDriversModelEvent>((event, emit) {
      emit(state.copyWith(
        driversModelOnline: event.driversModelOnline,
        
      ));
    });

        on<EnableDriversModelEvent>((event, emit) {
      emit(state.copyWith(
        enableDriverModel: event.enableDriversModel,
        
      ));
    });
    //conductor acepta viaje
    on<EnableDriverRequested>(_enableDriver);
  }

  @override
  DriversState? fromJson(Map<String, dynamic> json) {
    try {

    final onlineJson = json['driversModelOnline'] as Map<String, dynamic>?;
    final enableJson = json['enableDriversModel'] as Map<String, dynamic>?;

    final online = onlineJson == null ? null : DriversModel.fromJson(onlineJson);
    final enable = enableJson == null ? null : DriversModel.fromJson(enableJson);

    return DriversState(
      driversModelOnline: online,
      enableDriverModel: enable,
    );

    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(DriversState state) {

    final map = <String, dynamic>{};

    if (state.driversModelOnline != null) {
    map['driversModelOnline'] = state.driversModelOnline!.toJson();
    }
    if (state.enableDriverModel != null) {
    map['enableDriversModel'] = state.enableDriverModel!.toJson();
    }

  return map.isEmpty ? null : map;
  }

  void getDriversAndBases() {
    
    stopPeriodicTasck();

    timer = Timer.periodic(const Duration(seconds: 3), (_) async {

      if (authBloc.state.admin == null) {
          stopPeriodicTasck();
          add(const OnClearStateEvent());
           return;
         }

      
        final DriversModel model = await driverBaseService.getDriversAndBase();   

        //filtro los conductores dejando solo los que tiene el campo online en su estructura       

        final all = model.data?.drivers ?? const <Driver>[];

        // Con online (no null)
        final withOnline = all.where((driver) => driver.online != null).toList();

        // Sin online
        final withoutOnline = all.where((driver) => driver.online == null).toList();

        // DriversModel con online
        final driversModelOnline = model.copyWith(
        data: model.data?.copyWith(drivers: withOnline),
        );

        // DriversModel sin online
        final enableDriverModel = model.copyWith(
        data: model.data?.copyWith(drivers: withoutOnline),
        );

      if (model.ok == true) {
        add(UpdateDriversModelEvent(driversModelOnline));
        add(EnableDriversModelEvent(enableDriverModel));
      }

    });
  }

  //aceptar viaje
  void _enableDriver(EnableDriverRequested event, Emitter<DriversState> emit) async {

  final idDriver = event.idDriver;  
  
  if (idDriver.isNotEmpty) {
 
    // 🔵 Después hacemos la llamada al backend
   await driverBaseService.putEnableDriver(idDriver); 


  }
}

  void stopPeriodicTasck() {
    timer?.cancel();
    timer = null;
  }

  void loadingDataBase() {
    getDriversAndBases();
  }



  @override
  Future<void> close() {
    stopPeriodicTasck();  
    return super.close();
  }
}

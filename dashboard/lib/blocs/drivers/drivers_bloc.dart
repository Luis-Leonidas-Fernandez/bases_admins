import 'dart:async';

import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/models/drivers.dart';
import 'package:transport_dashboard/service/drivers_base_service.dart';
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

    // Ejecutar inmediatamente la primera vez
    _fetchDriversData();

    // Luego iniciar el timer periódico
    timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      _fetchDriversData();
    });
  }

  Future<void> _fetchDriversData() async {
    if (authBloc.state.admin == null) {
      stopPeriodicTasck();
      add(const OnClearStateEvent());
      return;
    }

    try {
      final result = await driverBaseService.getDriversAndBase();
      
      // Si retorna null o no retorna nada (porque uid o base son null), no hacer nada
      if (result == null || result is! DriversModel) return;

      final DriversModel model = result;

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

      // Actualizar el estado incluso si ok == false (para que la UI pueda manejar el caso)
      // Si ok == false, aún actualizamos para evitar que se quede en loading infinito
      add(UpdateDriversModelEvent(driversModelOnline));
      add(EnableDriversModelEvent(enableDriverModel));
    } catch (e) {
      // Si hay error, imprimir para debugging pero no crashear
      // ignore: avoid_print
      print('Error fetching drivers: $e');
    }
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

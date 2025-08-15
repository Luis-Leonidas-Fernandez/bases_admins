part of 'drivers_bloc.dart';


class DriversState extends Equatable{

  final DriversModel ? driversModelOnline; 
  final DriversModel ? enableDriverModel; 

  const  DriversState({
  this.driversModelOnline,  
  this.enableDriverModel,
  

});

 DriversState copyWith({
  DriversModel? driversModelOnline, 
  DriversModel? enableDriverModel,
 
})
=>  DriversState(
  driversModelOnline: driversModelOnline?? this.driversModelOnline,  
  enableDriverModel: enableDriverModel?? this.enableDriverModel,
 
);


  
  @override
  List<Object?> get props => [driversModelOnline,enableDriverModel ];
}

class DriverInitialState extends DriversState {
  const DriverInitialState(): super( driversModelOnline: null, enableDriverModel: null );
}

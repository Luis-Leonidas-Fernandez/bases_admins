part of 'drivers_bloc.dart';


class DriversEvent extends Equatable{

  const DriversEvent();

  @override
  List<Object?> get props => [];
}


class GetDriverAndBaseUserEvent extends DriversEvent{}


class UpdateDriversModelEvent extends DriversEvent{

  final DriversModel driversModelOnline;   // Solo con online != null
  
  const UpdateDriversModelEvent(this.driversModelOnline);

}



class EnableDriversModelEvent extends DriversEvent{

  final DriversModel enableDriversModel;
  const EnableDriversModelEvent(this.enableDriversModel);

}

class EnableDriverRequested extends DriversEvent{
  final String idDriver;
  const EnableDriverRequested(this.idDriver);
}

class OnClearStateEvent extends DriversEvent{
  
  const OnClearStateEvent();

}
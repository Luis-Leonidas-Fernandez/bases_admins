part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {
  
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class AddBaseEvent extends BaseEvent {

  final BaseModel? baseModel;
  const AddBaseEvent(this.baseModel);
  
  @override
  List<Object?> get props => [baseModel];
}

class CreateBaseRequested extends BaseEvent {
  final BaseModel? baseSelected;
  final String uid;
  
  const CreateBaseRequested({
    required this.baseSelected,
    required this.uid,
  });
  
  @override
  List<Object?> get props => [baseSelected, uid];
}

class ClearErrorEvent extends BaseEvent {
  const ClearErrorEvent();
}

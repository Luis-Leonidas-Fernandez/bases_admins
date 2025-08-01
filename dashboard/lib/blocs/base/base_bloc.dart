import 'package:bloc/bloc.dart';
import 'package:dashborad/models/bases.dart';
import 'package:dashborad/service/base_service.dart';
import 'package:equatable/equatable.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {

  final BaseService baseService;

  BaseBloc({required this.baseService}) : super(const BaseState(baseModel: null)) {
    
    on<AddBaseEvent>((event, emit) {
      emit(state.copyWith(baseModel: event.baseModel));
    });
  }

  Future<bool> createBase(BaseModel? baseSelected, String uid) async {
     
    final base = await baseService.createBase(baseSelected, uid);

      

    if(base is BaseModel){

      add(AddBaseEvent(base));
      return true;
    } else {
      return false;
    }

  }
}

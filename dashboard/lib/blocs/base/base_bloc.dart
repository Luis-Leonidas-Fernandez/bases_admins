import 'package:bloc/bloc.dart';
import 'package:transport_dashboard/models/bases.dart';
import 'package:transport_dashboard/service/base_service.dart';
import 'package:equatable/equatable.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {

  final BaseService baseService;

  BaseBloc({required this.baseService}) : super(const BaseState(baseModel: null)) {
    
    on<AddBaseEvent>((event, emit) {
      emit(state.copyWith(baseModel: event.baseModel));
    });
    
    on<CreateBaseRequested>(_onCreateBaseRequested);
    on<ClearErrorEvent>((event, emit) {
      emit(state.copyWith(clearError: true));
    });
  }

  Future<void> _onCreateBaseRequested(
    CreateBaseRequested event,
    Emitter<BaseState> emit,
  ) async {
    // Si ya está cargando, ignorar la petición
    if (state.isLoading) return;
    
    emit(state.copyWith(isLoading: true, clearError: true));
    
    try {
      final base = await baseService.createBase(event.baseSelected, event.uid);

      if(base is BaseModel){
        emit(state.copyWith(
          baseModel: base,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Error al crear la base',
        ));
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error en BaseBloc.createBase: $e");
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: errorMsg,
      ));
    }
  }

  Future<bool> createBase(BaseModel? baseSelected, String uid) async {
    // Usar el evento para mantener consistencia
    add(CreateBaseRequested(baseSelected: baseSelected, uid: uid));
    
    // Esperar a que termine el proceso
    await for (final state in stream) {
      if (!state.isLoading) {
        return state.baseModel != null;
      }
    }
    return false;
  }
}

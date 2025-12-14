part of 'base_bloc.dart';

class BaseState extends Equatable {
 
  final BaseModel ? baseModel; 
  final bool isLoading;
  final String? errorMessage;
  
  const BaseState({
    this.baseModel,
    this.isLoading = false,
    this.errorMessage,
  });

  BaseState copyWith({
      BaseModel? baseModel,
      bool? isLoading,
      String? errorMessage,
      bool clearError = false,
  })
  => BaseState(
    baseModel: baseModel?? this.baseModel,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );

  
  @override
  List<Object?> get props => [baseModel, isLoading, errorMessage];
}



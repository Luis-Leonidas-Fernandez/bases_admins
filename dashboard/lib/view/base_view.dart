import 'package:transport_dashboard/blocs/base/base_bloc.dart';
import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/models/bases.dart';
import 'package:transport_dashboard/service/storage_service.dart';
import 'package:transport_dashboard/widgets/interactive_map.dart';
import 'package:transport_dashboard/widgets/base_error_dialog.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BasePage extends StatefulWidget {


  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState(); 

}

class _BasePageState extends State<BasePage> {



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) { 
           
             return MapZonas(size: size); 
           
          }
          )
      ),
    );
  }
}

class MapZonas extends StatefulWidget {
 
  final Size size;
  const MapZonas({super.key, required this.size});

  @override
  State<MapZonas> createState() => _MapZonasState();
}

class _MapZonasState extends State<MapZonas> {
  
   @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(


        children: [

          SelectArea(size: widget.size),

          const ButtonGoHome()

          


        ] 
      ),
    );
  }
}

class TittleAddZona extends StatelessWidget {
  
  final Size size;
  const TittleAddZona({super.key, required this.size});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        const SizedBox(height: 50),
        Center(
          child: Container(
              color: Colors.transparent,
              width: size.width * 0.9,
              height: size.height * 0.1,
              child: Text(
                AppLocalizations.of(context)?.createBaseInZone ?? 'Crea tu Base en la Zona que quieras',
                style:  GoogleFonts.satisfy(
                  fontSize: size.width > 1100 ? 43 : 25,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 2, 31, 192),
                  letterSpacing: .7
                   ),
              ),
          ),
        ),
      ],
    );
  }
}

class SelectArea extends StatefulWidget {

  final Size size;
  const SelectArea({super.key, required this.size});

  @override
  State<SelectArea> createState() => _SelectAreaState();
}

class _SelectAreaState extends State<SelectArea> {
  // Callback to update coordinates for the currently editing zone
  Function(LatLng)? _coordinateUpdateCallback;
  Function(LatLng)? _onMapMovedCallback; // Callback para cuando el mapa se mueve

  @override
  void initState() {
    super.initState();
    // Despachar evento para obtener ubicación del usuario
    context.read<LocationBloc>().add(const GetCurrentLocationEvent());
  }

  // Method to set the callback (called by DroopButtons when entering edit mode)
  void setCoordinateUpdateCallback(Function(LatLng)? callback) {
    setState(() {
      _coordinateUpdateCallback = callback;
    });
  }

  // Method to clear the callback (called when exiting edit mode)
  void clearCoordinateUpdateCallback() {
    setState(() {
      _coordinateUpdateCallback = null;
    });
  }

  // Method to set the map moved callback
  void setMapMovedCallback(Function(LatLng)? callback) {
    // No hacer setState, solo asignar directamente (no necesitamos reconstruir el widget)
    _onMapMovedCallback = callback;
  }

  // Handle map tap
  void _onMapTap(LatLng point) {
    if (_coordinateUpdateCallback != null) {
      _coordinateUpdateCallback!(point);
      // Clear callback after coordinate is captured
      clearCoordinateUpdateCallback();
    }
  }

  // Handle map movement
  void _onMapMoved(LatLng point) {
    if (_onMapMovedCallback != null) {
      _onMapMovedCallback!(point);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        // Determinar ubicación a usar según el estado
        LatLng? locationToUse;
        
        if (locationState is LocationLoaded) {
          locationToUse = locationState.location;
        } else if (locationState is LocationError) {
          locationToUse = locationState.defaultLocation;
        } else if (locationState is LocationInitial) {
          locationToUse = const LatLng(-27.3254869, -58.65748235);
        }
        
        // Mostrar loading mientras se obtiene la ubicación
        if (locationState is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        return ListView(
          children: [
            const SizedBox(height: 15),
            TittleAddZona(size: widget.size),
              Stack(
                children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Radio de esquinas redondeadas
                  child: Container(
                    color: Colors.transparent,
                    width: widget.size.width * 0.85,
                    height: widget.size.width > 1100 ? widget.size.height * 1.15 : widget.size.height * 0.55,
                    child: InteractiveMap(
                      size: Size(widget.size.width * 0.85, widget.size.width > 1100 ? widget.size.height * 1.15 : widget.size.height * 0.55),
                      onMapTap: _onMapTap,
                      onMapMoved: _onMapMoved,
                      initialCenter: locationToUse,
                    ),
                  ),
                ),
                // Posicionar el icono y texto en el centro del mapa
                Positioned(
                  top: (widget.size.width > 1100 ? widget.size.height * 1.15 : widget.size.height * 0.55) / 2 - 35, // Ajustado para centrar mejor
                  left: (widget.size.width * 0.85) / 2 - 25, // Centrar horizontalmente (icono de 50/2 = 25)
                  child: DroopButton(
                    onEditModeChanged: setCoordinateUpdateCallback,
                    onMapMoved: setMapMovedCallback,
                    initialLocation: locationToUse,
                  ),
                ),
              ],
            ),
            Container(width: widget.size.width, height: 50, color: Colors.transparent,),
          ],
        );
      },
    );
  }
}

class ButtonGoHome extends StatefulWidget {

 

  const ButtonGoHome({super.key});

  @override
  State<ButtonGoHome> createState() => _ButtonGoHomeState();
}

class _ButtonGoHomeState extends State<ButtonGoHome> {
  bool _isDialogShowing = false; // Flag para controlar si el modal está abierto

  @override
  Widget build(BuildContext context) {
    
    final basebloc = BlocProvider.of<BaseBloc>(context);   
   

    return BlocListener<BaseBloc, BaseState>(
      listener: (context, state) {
        // Manejar error - solo mostrar si no está ya mostrado
        if (state.errorMessage != null && 
            !state.isLoading && 
            !_isDialogShowing && 
            context.mounted) {
          _isDialogShowing = true; // Marcar que el modal está abierto
          
          // Mostrar diálogo de error
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => BaseErrorDialog(
              onClose: () {
                // Callback para resetear el flag cuando se cierra
                if (mounted) {
                  setState(() {
                    _isDialogShowing = false;
                  });
                }
              },
            ),
          ).then((_) {
            // Asegurarse de resetear el flag cuando el modal se cierra (por cualquier razón)
            if (mounted) {
              setState(() {
                _isDialogShowing = false;
              });
            }
          });
        }
        
        // Solo navegar cuando termine de cargar y haya un resultado
        if (!state.isLoading && 
            state.baseModel != null && 
            state.errorMessage == null && 
            context.mounted) {
          // Verificar que la base tenga los datos necesarios para considerar que se creó exitosamente
          if (state.baseModel!.id != null && state.baseModel!.id!.isNotEmpty) {
            GoRouter.of(context).push('/dialog');
          }
        }
      },
      child: Positioned(
         bottom: 25,
         left: 0,
         right: 0,
        child: BlocBuilder<BaseBloc, BaseState>(
          builder: (context, state) {
            final bool isLoading = state.isLoading;
            final size = MediaQuery.of(context).size;
            final isTabletOrWeb = size.width >= 856; // Tablet y web
            
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: isTabletOrWeb 
                    ? size.width * 0.25  // 25% del ancho total para tablet/web
                    : size.width - 50,   // Ancho completo menos padding para mobile (left: 25, right: 25)
                child: ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    final uid = StorageService.prefs.getString('uid');
                    if (uid == null || uid.isEmpty) return;
                    
                    final base = basebloc.state.baseModel;
                    
                    // POST CREAR BASE usando evento
                    basebloc.add(CreateBaseRequested(
                      baseSelected: base,
                      uid: uid,
                    ));
                  },

                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return const Color.fromARGB(180, 150, 170, 255); // Color más claro y visible cuando se presiona
                        }
                        if (states.contains(WidgetState.hovered)) {
                          return const Color.fromARGB(120, 122, 140, 241); // Color semitransparente al hacer hover
                        }
                        return const Color.fromARGB(100, 122, 140, 241); // Color por defecto semitransparente
                      },
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      isLoading 
                        ? Colors.grey
                        : const Color.fromARGB(255, 11, 38, 192)
                    ),
                    minimumSize: WidgetStateProperty.all(Size.zero), // Permite que el botón sea más pequeño
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  child: isLoading 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)?.next ?? 'SIGUIENTE',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

class DroopButton extends StatefulWidget {

  final Function(Function(LatLng)?)? onEditModeChanged;
  final Function(Function(LatLng)?)? onMapMoved; // Callback para registrar el callback de movimiento del mapa
  final LatLng? initialLocation;
  
  const DroopButton({
    super.key, 
    this.onEditModeChanged, 
    this.onMapMoved,
    this.initialLocation,
  });

  @override
  State<DroopButton> createState() => _DroopButtonState();
}

class _DroopButtonState extends State<DroopButton> {
  // Solo necesitamos ubicacion, el backend calcula zona y base automáticamente
  List<double>? ubicacion = [-58.65748235, -27.3254869];
  bool isEditingCoordinates = false;
  bool hasSelectedLocation = false; // Variable para saber si se seleccionó ubicación manualmente

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  void _updateCoordinate(LatLng point) {
    setState(() {
      ubicacion = [point.longitude, point.latitude];
      isEditingCoordinates = false;
      hasSelectedLocation = true; // Marcar que se seleccionó la ubicación
    });
    widget.onEditModeChanged?.call(null);
    
    // Actualizar el BaseModel en el bloc con solo la ubicación
    _updateBaseModel();
  }

  void _updateBaseModel() {
    if (ubicacion != null) {
      final value = {"ubicacion": ubicacion};
      final data = BaseModel.fromJson(value);
      final baseBloc = BlocProvider.of<BaseBloc>(context);
      baseBloc.add(AddBaseEvent(data));
    }
  }

  void _enableCoordinateEdit() {
    setState(() {
      isEditingCoordinates = true;
    });
    widget.onEditModeChanged?.call(_updateCoordinate);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BaseBloc>(context);
    
    // Inicializar ubicación con la ubicación del usuario o valores por defecto
    if (widget.initialLocation != null) {
      ubicacion = [widget.initialLocation!.longitude, widget.initialLocation!.latitude];
    } else {
      ubicacion = [-58.65748235, -27.3254869];
    }
    
    // Registrar el callback después del build usando addPostFrameCallback
    // Esto evita el error de setState durante el build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onMapMoved?.call(_onMapMoved);
    });
    
    // Inicializar el BaseModel en el bloc
    _updateBaseModel();
  }

  // Método llamado cuando el mapa se mueve
  void _onMapMoved(LatLng point) {
    setState(() {
      ubicacion = [point.longitude, point.latitude];
      hasSelectedLocation = true; // Marcar que se seleccionó una ubicación
    });
    
    // Actualizar el BaseModel en el bloc con la nueva ubicación
    _updateBaseModel();
  }

  @override
  void dispose() {    
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return GestureDetector(
          onLongPress: _enableCoordinateEdit,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icono de ubicación
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 8),
              // Mensaje debajo del icono
              Text(
                hasSelectedLocation 
                    ? (AppLocalizations.of(context)?.pressNext ?? 'Presiona SIGUIENTE')
                    : (AppLocalizations.of(context)?.selectZone ?? 'Seleccionar zona'),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              // Mostrar indicador cuando está en modo edición
              if (isEditingCoordinates)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Toca el mapa',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      }
    );
    
    
    
  }
}

import 'package:dashborad/blocs/blocs.dart';
import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/models/drivers.dart' hide DriversState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnableDriverPage extends StatelessWidget {

  const EnableDriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Habilitar conductores',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF4B0082),
          ),
        ),
        centerTitle: true,
      ),

      // Solo reconstruye cuando cambia driversModel
      body: BlocSelector<DriversBloc, DriversState, DriversModel?>(
        selector: (state) => state.enableDriverModel,
        builder: (context, enabledriversMode1) {

          if ( enabledriversMode1 == null) {
            return const Center(child: CircularProgressIndicator());
          }


           final data = enabledriversMode1.data;
          final allDrivers = data?.drivers ?? const <Driver>[];

          // ✅ Por si acaso, aunque ya debería venir filtrado desde el bloc:
          final drivers = allDrivers.where((d) => d.online == null).toList();

          if (drivers.isEmpty) {
            return const Center(
              child: Text('No hay conductores para mostrar.',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Column(
              children: [

                if ((data?.zonaName ?? '').isNotEmpty)

                  Text(
                    'Zona: ${data?.zonaName} Base: ${data?.base}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4B0082),
                    ),
                  ),

                const SizedBox(height: 4),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {

                      final driver = drivers[index];

                      //extraer datos del conductor
                      final nombre = (driver.nombre ?? '').trim();
                      final apellido = (driver.apellido ?? '').trim();
                      final vehiculo = _vehiculoTexto(driver);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: tableColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: containerColor,
                                child: Text(
                                  _initials(nombre, apellido),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${nombre.isEmpty ? '—' : nombre} ${apellido.isEmpty ? '' : apellido}'.trim(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: containerColor,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.directions_car,
                                            size: 18, color: Colors.deepPurple),
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            vehiculo ?? 'Sin vehículo',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: containerColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: (driver.id == null || driver.id!.isEmpty)
                                    ? null
                                    : () {
                                        // Dispara tu evento del bloc para habilitar
                                         context.read<DriversBloc>().add(
                                         EnableDriverRequested(driver.id!), // <-- ajusta el nombre si difiere
                                        );

                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Procesando habilitación...')),
                                         );
                                       });
                                      },
                                child: const Text('Habilitar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _initials(String nombre, String apellido) {
    final i1 = nombre.isNotEmpty ? nombre.characters.first : '';
    final i2 = apellido.isNotEmpty ? apellido.characters.first : '';
    final s = (i1 + i2).toUpperCase();
    return s.isEmpty ? '?' : s;
  }

  String? _vehiculoTexto(Driver d) {
    // Se muestra SOLO `vehiculo`. Si está vacío, fallback a `modelo + patente`.
    final v = (d.vehiculo ?? '').trim();
    if (v.isNotEmpty) return v;

    final modelo = (d.modelo ?? '').trim();
    final patente = (d.patente ?? '').trim();
    final composed = [modelo, patente].where((e) => e.isNotEmpty).join(' ');
    return composed.isEmpty ? null : composed;
  }
}
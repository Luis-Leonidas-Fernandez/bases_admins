import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/service/history.dart';
import 'package:flutter/material.dart';
import 'package:dashborad/models/travels.dart';
import 'package:intl/intl.dart';

class TravelHistoryPage extends StatefulWidget {
  final String driverId;

  const TravelHistoryPage({super.key, required this.driverId});

  @override
  State<TravelHistoryPage> createState() => _TravelHistoryPageState();
}

class _TravelHistoryPageState extends State<TravelHistoryPage> {
  late Future<TravelModel?> _futureViajes;

  @override
  void initState() {
    super.initState();
   _loadViajes();
  }

  @override
void didUpdateWidget(covariant TravelHistoryPage oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.driverId != widget.driverId) {
    _loadViajes();
    
  }
}

  String formatDate(DateTime? date) {
    if (date == null) return '--';
    return DateFormat('dd MMM yyyy').format(date);
  }

  void _loadViajes() {
  setState(() {
    _futureViajes = TravelHistoryService().getViajesDriver(widget.driverId);
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FB), // Fondo general
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Historial de Viajes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF4B0082),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<TravelModel?>(
        future: _futureViajes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.viajes.isEmpty) {
            return const Center(
              child: Text(
                'No hay viajes disponibles.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final viajes = snapshot.data!.viajes;

          return Padding(
             padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Column(
              children: [
                Text(
                  'Total de viajes: ${snapshot.data!.total}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4B0082),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Balance: \$${snapshot.data!.balance}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4B0082),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: viajes.length,
                    itemBuilder: (context, index) {
                      final viaje = viajes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: tableColor, // Color más claro del sidebar
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '🧭 Distancia: ${viaje.distancia?.toStringAsFixed(2) ?? '--'} km',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: containerColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.attach_money, size: 18, color: Colors.deepPurple),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Precio: \$${viaje.precio ?? 0}',
                                    style: TextStyle(color: containerColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.check_circle, size: 18, color: Colors.green),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Finalizado: ${viaje.finalizado == true ? "Sí" : "No"}',
                                    style: TextStyle(color: containerColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 18, color: Colors.deepPurple),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Creado: ${formatDate(viaje.createdAt)}',
                                    style: TextStyle(color: containerColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.update, size: 18, color: Colors.deepPurple),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Actualizado: ${formatDate(viaje.updatedAt)}',
                                    style: TextStyle(color: containerColor),
                                  ),
                                ],
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
}

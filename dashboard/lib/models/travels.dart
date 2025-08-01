class TravelModel {
  final bool ok;
  final int total;
  final int balance;
  final List<Viaje> viajes;

  TravelModel({required this.ok, required this.total,required this.balance, required this.viajes});

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
        ok: json['ok'],
        total: json['total'],
        balance: json['balance'] ?? 0,
        viajes: List<Viaje>.from(json['viajes'].map((x) => Viaje.fromJson(x))),
      );
}

class Viaje {
  final String? id;
  final String? driverId;
  final Ubicacion? ubicacion;
  final Ubicacion? destino;
  final double? distancia;
  final int? precio;
  final bool? finalizado;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Viaje({
    this.id,
    this.driverId,
    this.ubicacion,
    this.destino,
    this.distancia,
    this.precio,
    this.finalizado,
    this.createdAt,
    this.updatedAt,
  });

  factory Viaje.fromJson(Map<String, dynamic> json) => Viaje(
        id: json['_id'],
        driverId: json['driverId'],
        ubicacion: Ubicacion.fromJson(json['ubicacion']),
        destino: Ubicacion.fromJson(json['destino']),
        distancia: json['distancia'].toDouble(),
        precio: json['precio'],
        finalizado: json['finalizado'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
}

class Ubicacion {
  final String type;
  final List<double> coordinates;

  Ubicacion({required this.type, required this.coordinates});

  factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        type: json['type'],
        coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
      );
}

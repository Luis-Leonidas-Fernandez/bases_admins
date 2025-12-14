
class BaseModel {

    bool? ok;
    int? base; // Cambiado de String? a int?
    List<double>? ubicacion;
    String? adminId;
    String? zonaName;
    List<dynamic>? idDriver;
    int? viajes;
    String? id;

    BaseModel({

        this.ok,
        this.base,
        this.ubicacion,
        this.adminId,
        this.zonaName,
        this.idDriver,
        this.viajes,
        this.id,
    });


 

    factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        base: json["base"] is int ? json["base"] : (json["base"] is String ? int.tryParse(json["base"]) : null),
        ubicacion: _parseUbicacion(json["ubicacion"]),
        adminId: json["adminId"]?.toString() ?? "",
        zonaName: json["zonaName"]?.toString() ?? "",
        idDriver: json["idDriver"] == null ? null : List<dynamic>.from(json["idDriver"].map((x) => x)),
        viajes: json["viajes"]?? 0,
        id: json["_id"]?.toString() ?? "",
    );

    // Helper method para parsear ubicacion (puede venir como objeto GeoJSON o como array)
    static List<double>? _parseUbicacion(dynamic ubicacionData) {
      if (ubicacionData == null) return null;
      
      // Si viene como objeto GeoJSON {type: "Point", coordinates: [...]}
      if (ubicacionData is Map<String, dynamic>) {
        if (ubicacionData.containsKey('coordinates')) {
          final coordinates = ubicacionData['coordinates'];
          if (coordinates is List) {
            return List<double>.from(coordinates.map((x) => x.toDouble()));
          }
        }
      }
      
      // Si viene como array directamente
      if (ubicacionData is List) {
        return List<double>.from(ubicacionData.map((x) => x.toDouble()));
      }
      
      return null;
    }

    Map<String, dynamic> toMap() => {
        "base": base,
        "ubicacion": ubicacion == null? null : List<dynamic>.from(ubicacion!.map((x) => x)),
        "adminId": adminId,
        "zonaName": zonaName,
        "idDriver": idDriver == null ? null : List<dynamic>.from(idDriver!.map((x) => x)),
        "viajes": viajes,
        "_id": id,
    };
}


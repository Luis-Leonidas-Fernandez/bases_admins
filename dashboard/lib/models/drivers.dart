import 'dart:convert';


class DriversModel {
    bool? ok;
    Data? data;

    DriversModel({
        this.ok,
        this.data,
    });

    //factory DriversModel.fromJson(String str) => DriversModel.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory DriversModel.fromJson(Map<String, dynamic> json) => DriversModel(
        ok: json["ok"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "data": data!.toMap(),
    };
}

class Data {
    String? id;
    int? base;
    int? viajes;
    String? adminId;
    String? zonaName;
    Ubicacion? ubicacion;
    List<Driver>? drivers;

    Data({
        this.id,
        this.base,
        this.viajes,
        this.adminId,
        this.zonaName,
        this.ubicacion,
        this.drivers,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["_id"]?? "",
        base: json["base"] ?? 0,
        viajes: json["viajes"] ?? 0,
        adminId: json["adminId"] ?? "",
        zonaName: json["zonaName"] ?? "",
        ubicacion: json["ubicacion"] == null? null : Ubicacion.fromMap(json["ubicacion"]),
        drivers: json["drivers"]     == null? null : List<Driver>.from(json["drivers"].map((x) => Driver.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "base": base,
        "viajes": viajes,
        "adminId": adminId,
        "zonaName": zonaName,
        "ubicacion":  ubicacion?.toMap(),
        "drivers": drivers == null ? "" : List<dynamic>.from(drivers!.map((x) => x.toMap())),
    };

     Map<String, dynamic> toJson() => {
        "_id": id,
        "base": base,
        "viajes": viajes,
        "adminId": adminId,
        "zonaName": zonaName,
        "ubicacion":  ubicacion?.toMap(),
        "drivers": drivers == null ? "" : List<dynamic>.from(drivers!.map((x) => x.toMap())),
    };
}

class Driver {
    String? id;
    String? email;
    String? nombre;
    String? apellido;
    String? nacimiento;
    String? domicilio;
    String? vehiculo;
    String? modelo;
    String? patente;
    String? licencia;
    bool? online;
    String? role;
    String? order;
    String? status;
    int? viajes;
    List<dynamic>? idAddress;
    DateTime? time;
    List<String>? cupon;

    Driver({
        this.id,
        this.email,
        this.nombre,
        this.apellido,
        this.nacimiento,
        this.domicilio,
        this.vehiculo,
        this.modelo,
        this.patente,
        this.licencia,
        this.online,
        this.role,
        this.order,
        this.status,
        this.viajes,
        this.idAddress,
        this.time,
        this.cupon,
    });

    factory Driver.fromJson(String str) => Driver.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Driver.fromMap(Map<String, dynamic> json) => Driver(
        id: json["_id"] ?? "",
        email: json["email"] ?? "",
        nombre: json["nombre"] ?? "",
        apellido: json["apellido"] ?? "",
        nacimiento: json["nacimiento"] ?? "",
        domicilio: json["domicilio"] ?? "",
        vehiculo: json["vehiculo"] ?? "",
        modelo: json["modelo"] ?? "",
        patente: json["patente"] ?? "",
        licencia: json["licencia"] ?? "",
        online: json["online"] ?? false,
        role: json["role"] ?? "",
        order: json["order"] ?? "",
        status: json["status"] ?? "",
        viajes: json["viajes"] ?? 0,
        idAddress: json["idAddress"] == null? null : List<dynamic>.from(json["idAddress"].map((x) => x)),
        time: json["time"] == null? null : DateTime.parse(json["time"]),
        cupon: json["cupon"] == null? null : List<String>.from(json["cupon"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "id": id ?? "",
        "email": email ?? "",
        "nombre": nombre ?? "",
        "apellido": apellido ?? "",
        "nacimiento": nacimiento ?? "",
        "domicilio": domicilio ?? "",
        "vehiculo": vehiculo ?? "",
        "modelo": modelo ?? "",
        "patente": patente ?? "",
        "licencia": licencia ?? "",
        "online": online ?? false,
        "role": role ?? "",
        "order": order ?? "",
        "status": status ?? "",
        "viajes": viajes ?? 0,
        "idAddress": idAddress == null ? null : List<dynamic>.from(idAddress!.map((x) => x)),
        "time": time == null ? "" : time!.toIso8601String(),
        "cupon": cupon == null? null : List<dynamic>.from(cupon!.map((x) => x)),
    };

    
}

class Ubicacion {
    String type;
    List<double> coordinates;

    Ubicacion({
        required this.type,
        required this.coordinates,
    });

    factory Ubicacion.fromJson(String str) => Ubicacion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ubicacion.fromMap(Map<String, dynamic> json) => Ubicacion(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}


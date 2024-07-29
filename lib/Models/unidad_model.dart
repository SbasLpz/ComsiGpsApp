class UnidadModel {
    String? id;
    String? lat;
    String? long;
    String? id_gps;
    String? desc;
    String? orden;
    String? tipo;
    String? placa;
    String? fecha1;
    String? fecha2;
    String? lugar;
    String? estado;
    String? id_reporte;
    String? velocidad;
    String? foto;
    String? bateria;
    String? foto2;
    String? foto3;
    String? foto4;
    String? icono;
    String? tamano;
    String? orientacion;
    String? altitud;
    String? aceleracion;
    String? desaceleracion;
    String? rpm;
    String? hdop;
    String? consumoprom;
    String? gsm;
    String? gpslost;
    String? combustible;
    String? relaystatus;
    String? ignitionstatus;
    String? odometro;
    String? last;
    String? dirPunto;
    String? namePiloto;
    String? nombres;
    String? apellidos;
    String? id_piloto;
    String? descGps;
    String? descModulo;
    String? bb;
    String? chasis;
    String? temp1;
    String? year;
    String? color;
    String? capacidad_gas;
    String? marca;

    UnidadModel({
      this.id,
      this.lat,
      this.long,
      this.id_gps,
      this.desc,
      this.orden,
      this.tipo,
      this.placa,
      this.fecha1,
      this.fecha2,
      this.lugar,
      this.estado,
      this.id_reporte,
      this.velocidad,
      this.foto,
      this.bateria,
      this.foto2,
      this.foto3,
      this.foto4,
      this.icono,
      this.tamano,
      this.orientacion,
      this.altitud,
      this.aceleracion,
      this.desaceleracion,
      this.rpm,
      this.hdop,
      this.consumoprom,
      this.gsm,
      this.gpslost,
      this.combustible,
      this.relaystatus,
      this.ignitionstatus,
      this.odometro,
      this.last,
      this.dirPunto,
      this.namePiloto,
      this.nombres,
      this.apellidos,
      this.id_piloto,
      this.descGps,
      this.descModulo,
      this.bb,
      this.chasis,
      this.temp1,
      this.year,
      this.color,
      this.capacidad_gas,
      this.marca,
    });

    UnidadModel.fromJson(Map<String, dynamic> json) {
      id = json['id_vehiculo'];
      lat = json['latitud'];
      long = json['longitud'];
      id_gps = json['id_gps'];
      desc = json['descr'];
      orden = json['orden1'];
      tipo = json['tipo'];
      placa = json['placa'];
      fecha1 = json['fecha1'];
      fecha2 = json['fecha2'];
      lugar = json['lugar'];
      estado = json['estado'];
      id_reporte = json['id_reporte'];
      velocidad = json['velocidad'];
      foto = json['foto'];
      bateria = json['bateria'];
      foto2 = json['foto2'];
      foto3 = json['foto2'];
      foto4 = json['foto4'];
      icono = json['icono'];
      tamano = json['tamano'];
      orientacion = json['orientacion'];
      altitud = json['altitud'];
      aceleracion = json['aceleracion'];
      desaceleracion = json['desaceleracion'];
      rpm = json['rpm'];
      hdop = json['hdop'];
      consumoprom = json['consumoprom'];
      gsm = json['gsm'];
      gpslost = json['gpslost'];
      combustible = json['combustible'];
      relaystatus = json['relaystatus'];
      ignitionstatus = json['ignitionstatus'];
      odometro = json['odometro'];
      last = json['last'];
      dirPunto = json['dirPunto'];
      namePiloto = json['npiloto'];
      nombres = json['nombres'];
      apellidos = json['apellidos'];
      id_piloto = json['id_piloto'];
      descGps = json['descGPS'];
      descModulo = json['descModulo'];
      bb = json['bb'];
      chasis = json['chasis'];
      temp1 = json['temp1'];
      year = json['anio'];
      color = json['color'];
      capacidad_gas = json['capacidad_gas'];
      marca = json['marca'];
    }
}
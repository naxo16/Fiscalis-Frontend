import 'package:equatable/equatable.dart';

enum InfraccionStatus { cargando, error, guardadoLocal, sincronizado }

class Infraccion extends Equatable {
  final String id;
  final String? rutInfractor;
  final String? nombreCompleto;
  final String ppu; 
  final String? tipoVehiculo;
  final String? marcaVehiculo;
  final String? colorVehiculo;
  final int? tipoInfraccionId; // 1 = Advertencia, 2 = Citacion
  final String coordenadas; // Guardaremos "lat,lng"
  final List<String> fotos; // Rutas locales
  final DateTime fecha;
  final String descripcion;
  final bool firmaRechazo;
  final InfraccionStatus status;

  const Infraccion({
    required this.id,
    this.rutInfractor,
    this.nombreCompleto,
    required this.ppu,
    this.tipoVehiculo,
    this.marcaVehiculo,
    this.colorVehiculo,
    this.tipoInfraccionId,
    required this.coordenadas,
    required this.fotos,
    required this.fecha,
    required this.descripcion,
    this.firmaRechazo = false,
    this.status = InfraccionStatus.guardadoLocal,
  });

  @override
  List<Object?> get props => [id, ppu, coordenadas, fotos, status];
}
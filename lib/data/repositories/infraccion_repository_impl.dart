import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/infraccion.dart';
import '../../domain/repositories/i_infraccion_repository.dart';
import '../models/infraccion_model.dart';
import '../datasources/local/database.dart';

class InfraccionRepositoryImpl implements IInfraccionRepository {
  final AppDatabase db;
  final Dio dio;

  InfraccionRepositoryImpl(this.db, this.dio);

  @override
  Future<List<Infraccion>> getInfracciones() async {
    final rows = await db.select(db.actasInfraccion).get();
    final List<Infraccion> infracciones = [];
    for (var row in rows) {
      final evidencias = await (db.select(db.evidenciasFotograficas)
            ..where((t) => t.actaUuid.equals(row.uuid)))
          .get();
      final fotos = evidencias.map((e) => e.rutaLocal).toList();
      infracciones.add(InfraccionModel.fromDatabase(row, fotos: fotos));
    }
    return infracciones;
  }

  @override
  Stream<List<Infraccion>> watchInfracciones() {
    return db.select(db.actasInfraccion).watch().asyncMap((rows) async {
      final List<Infraccion> infracciones = [];
      for (var row in rows) {
        final evidencias = await (db.select(db.evidenciasFotograficas)
              ..where((t) => t.actaUuid.equals(row.uuid)))
            .get();
        final fotos = evidencias.map((e) => e.rutaLocal).toList();
        infracciones.add(InfraccionModel.fromDatabase(row, fotos: fotos));
      }
      return infracciones;
    });
  }

  @override
  Future<void> saveInfraccionLocal(Infraccion infraccion) async {
    double lat = 0.0;
    double lng = 0.0;
    if (infraccion.coordenadas.contains(',')) {
      final parts = infraccion.coordenadas.split(',');
      lat = double.tryParse(parts[0]) ?? 0.0;
      lng = double.tryParse(parts[1]) ?? 0.0;
    }

    // Se alinea a la nueva estructura DERA
    final companion = ActasInfraccionCompanion(
      uuid: Value(infraccion.id),
      rutInfractor: Value(infraccion.rutInfractor),
      nombreInfractor: Value(infraccion.nombreCompleto),
      ppu: Value(infraccion.ppu),
      latitud: Value(lat),
      longitud: Value(lng),
      observaciones: Value(infraccion.descripcion),
      estadoActa: const Value('PENDIENTE_SYNC'),
      // Valores por defecto para mantener compatibilidad con el repositorio antiguo
      tipoVehiculo: const Value('S/I'),
      colorVehiculo: const Value('S/I'),
      marcaVehiculo: const Value('S/I'),
      tipoInfraccionId: const Value(1),
      inspectorId: const Value(101),
      deviceId: const Value('APP'),
      createdAt: Value(infraccion.fecha),
    );

    try {
      await db.into(db.actasInfraccion).insert(companion);
    } catch (e) {
      throw Exception('Error al guardar localmente: $e');
    }
  }

  @override
  Future<void> syncInfraccion(Infraccion infraccion) async {
    try {
      final model = InfraccionModel.fromEntity(infraccion);

      final response = await dio.post(
        '/api/v1/infracciones/',
        data: model.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await (db.update(db.actasInfraccion)
              ..where((t) => t.uuid.equals(infraccion.id)))
            .write(ActasInfraccionCompanion(
          estadoActa: const Value('SYNCED'),
          syncedAt: Value(DateTime.now()),
        ));
      }
    } on DioException catch (e) {
      throw Exception('Error de sincronización: ${e.message}');
    }
  }
}
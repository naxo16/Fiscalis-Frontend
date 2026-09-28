import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart'; // Necesario para Value()
import '../datasources/local/database.dart';
import '../models/infraccion_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SyncService {
  final AppDatabase _db;
  final Dio _dio;
  final Connectivity _connectivity;

  SyncService({
    required AppDatabase db,
    required Dio dio,
    Connectivity? connectivity,
  })  : _db = db,
        _dio = dio,
        _connectivity = connectivity ?? Connectivity();

  Future<int> syncPendingInfracciones() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      print('SGF_CORE [Sync]: Sin conexión a internet.');
      return 0; // 0 sincronizados
    }

    // Busca los que el DERA manda
    final pendientes = await (_db.select(_db.actasInfraccion)
          ..where((t) => t.estadoActa.equals('PENDIENTE_SYNC')))
        .get();

    if (pendientes.isEmpty) {
      print('SGF_CORE [Sync]: No hay registros pendientes.');
      return 0; // 0 sincronizados
    }

    print('SGF_CORE [Sync]: Iniciando sincronización de ${pendientes.length} registros.');
    int successCount = 0;

    for (final row in pendientes) {
      try {
        final fotosRow = await (_db.select(_db.evidenciasFotograficas)
              ..where((t) => t.actaUuid.equals(row.uuid)))
            .get();
        
        final List<String> fotos = fotosRow.map((f) => f.hashIntegridad).toList();
        
        final model = InfraccionModel.fromDatabase(row, fotos: fotos);

        final response = await _dio.post(
          '/api/v1/infracciones/', 
          data: model.toJson(),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Actualiza según la llave UUID nueva
          await (_db.update(_db.actasInfraccion)
                ..where((t) => t.uuid.equals(row.uuid)))
              .write(
            ActasInfraccionCompanion(
              estadoActa: const Value('SYNCED'),
              syncedAt: Value(DateTime.now()),
            ),
          );
          print('SGF_CORE [Sync]: Registro ${row.uuid} sincronizado con éxito.');
          successCount++;
        } else {
          throw Exception('Código de respuesta inesperado: ${response.statusCode}');
        }
      } catch (e) {
        print('SGF_CORE [Sync Error]: Falló sincronización de ${row.uuid}. Razón: $e');
        if (e is DioException) {
          if (e.response != null) {
            throw Exception('Servidor: ${e.response?.data}');
          } else {
            throw Exception('Red: ${e.message}');
          }
        }
        throw Exception('Falló al sincronizar: $e');
      }
    }
    
    if (successCount > 0) {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'lastSyncTimestamp', value: DateTime.now().toIso8601String());
    }

    return successCount;
  }
}
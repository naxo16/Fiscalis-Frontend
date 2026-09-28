import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'database.g.dart';

/// Tablas desnormalizadas para la capa móvil Fiscalis según normativa DERA.
class ActasInfraccion extends Table {
  TextColumn get uuid => text().withLength(min: 36, max: 36)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  RealColumn get latitud => real()();
  RealColumn get longitud => real()();
  TextColumn get direccionFallback => text().nullable()();
  TextColumn get ppu => text()();
  TextColumn get nombreInfractor => text().nullable()();
  TextColumn get rutInfractor => text().nullable()();
  TextColumn get tipoVehiculo => text()();
  TextColumn get colorVehiculo => text()();
  TextColumn get marcaVehiculo => text()();
  IntColumn get tipoInfraccionId => integer()();
  TextColumn get observaciones => text()();
  IntColumn get inspectorId => integer()();
  TextColumn get estadoActa => text()(); // Enum: 'BORRADOR', 'PENDIENTE_SYNC', 'SINCRONIZADO'
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get deviceId => text()();
  BoolColumn get firmaRechazo => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {uuid};
}

class EvidenciasFotograficas extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get actaUuid => text().references(ActasInfraccion, #uuid)();
  TextColumn get rutaLocal => text()();
  TextColumn get hashIntegridad => text()(); // SHA-256
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [ActasInfraccion, EvidenciasFotograficas])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'fiscalis_secure.db'));
      
      // Obtener el JWT para usarlo como llave criptográfica
      const storage = FlutterSecureStorage();
      final jwtToken = await storage.read(key: 'jwt');
      final dbKey = jwtToken ?? 'temp_ram_key'; // Fallback temporal en caso de no haber sesión

      return NativeDatabase.createInBackground(file, setup: (db) {
        db.execute("PRAGMA key = '$dbKey';");
      });
    });
  }
}
import '../entities/infraccion.dart';

abstract class IInfraccionRepository {
  /// Obtiene todas las infracciones guardadas localmente o sincronizadas
  Future<List<Infraccion>> getInfracciones();

  /// Guarda una nueva infracción localmente (Drift)
  Future<void> saveInfraccionLocal(Infraccion infraccion);

  /// Sincroniza las infracciones pendientes con el backend FastAPI (Dio)
  /// Implementa idempotencia enviando el UUID local
  Future<void> syncInfraccion(Infraccion infraccion);

  /// Stream para observar cambios en tiempo real (Riverpod + Drift)
  Stream<List<Infraccion>> watchInfracciones();
}
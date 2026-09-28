import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart'; // REQUIRED FOR Value
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/datasources/local/database.dart'; // RUTA CORREGIDA
import 'infraccion_provider.dart';

class FormularioState {
  final double? latitud;
  final double? longitud;
  final List<Map<String, String>> fotosConHash;
  final bool isLoading;

  FormularioState({
    this.latitud,
    this.longitud,
    this.fotosConHash = const [],
    this.isLoading = false,
  });

  FormularioState copyWith({
    double? latitud,
    double? longitud,
    List<Map<String, String>>? fotosConHash,
    bool? isLoading,
  }) {
    return FormularioState(
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      fotosConHash: fotosConHash ?? this.fotosConHash,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class FormularioInfraccionNotifier extends StateNotifier<FormularioState> {
  final AppDatabase _db;
  final ImagePicker _picker = ImagePicker();
  final _storage = const FlutterSecureStorage();
  int _inspectorId = 101; // Inspector ID por defecto (fallback)

  FormularioInfraccionNotifier(this._db) : super(FormularioState()) {
    _initInspectorId();
  }

  Future<void> _initInspectorId() async {
    try {
      final idStr = await _storage.read(key: 'inspectorId');
      if (idStr != null) {
        _inspectorId = int.tryParse(idStr) ?? 101;
      }
    } catch (e) {
      // Si falla la lectura, se mantiene el fallback por defecto
    }
  }

  Future<void> capturarGPS() async {
    state = state.copyWith(isLoading: true);
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // 1. Verificar si el GPS físico del teléfono está encendido
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('El servicio de GPS está desactivado en el teléfono.');
      }

      // 2. Verificar si tenemos el permiso de la app
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Lanza el popup nativo de Android pidiendo permiso
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Permisos de ubicación denegados por el usuario.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Permisos bloqueados permanentemente en Android. Ve a Ajustes.');
      }

      // 3. Si todo está en regla, ahora sí capturamos la coordenada
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      
      state = state.copyWith(
        latitud: position.latitude,
        longitud: position.longitude,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> tomarFotografia() async {
    try {
      // Se limita resolución y calidad para evitar OutOfMemory y cierres (Activity Death) en Android
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera, 
        imageQuality: 50,
        maxWidth: 1280,
        maxHeight: 1280,
      );
      if (photo == null) return;

      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String fileName = '${const Uuid().v4()}.jpg';
      final String permanentPath = '${appDocDir.path}/$fileName';
      final File savedImage = await File(photo.path).copy(permanentPath);

      final bytes = await savedImage.readAsBytes();
      final hash = sha256.convert(bytes).toString();

      state = state.copyWith(
        fotosConHash: [
          ...state.fotosConHash,
          {'path': savedImage.path, 'hash': hash},
        ],
      );
    } catch (e) {
      // Fallback silencioso
    }
  }

  Future<void> recuperarFotoPerdida() async {
    try {
      if (Platform.isAndroid) {
        final LostDataResponse response = await _picker.retrieveLostData();
        if (response.isEmpty || response.file == null) return;

        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String fileName = '${const Uuid().v4()}.jpg';
        final String permanentPath = '${appDocDir.path}/$fileName';
        final File savedImage = await File(response.file!.path).copy(permanentPath);

        final bytes = await savedImage.readAsBytes();
        final hash = sha256.convert(bytes).toString();

        state = state.copyWith(
          fotosConHash: [
            ...state.fotosConHash,
            {'path': savedImage.path, 'hash': hash},
          ],
        );
      }
    } catch (e) {
      // Evitar que fallos nativos rompan la app
    }
  }

  void eliminarFotografia(String path) {
    final newFotos = state.fotosConHash.where((f) => f['path'] != path).toList();
    state = state.copyWith(fotosConHash: newFotos);

    try {
      final file = File(path);
      if (file.existsSync()) {
        file.deleteSync();
      }
    } catch (_) {
      // Ignorar errores al borrar
    }
  }

  Future<void> guardarActa({
    required String ppu,
    required String tipoVehiculo,
    required String colorVehiculo,
    required String marcaVehiculo,
    required String observaciones,
    String? nombreInfractor, // <-- NUEVO
    String? rutInfractor,    // <-- NUEVO
    int? tipoInfraccionId,   // <-- NUEVO (1 = Advertencia, 2 = Citación)
    bool firmaRechazo = false,
  }) async {
    if (state.latitud == null || state.fotosConHash.isEmpty) {
      throw Exception('Faltan datos obligatorios (GPS/Fotos)');
    }

    final actaUuid = const Uuid().v4();
    
    await _db.transaction(() async {
      await _db.into(_db.actasInfraccion).insert(
        ActasInfraccionCompanion.insert(
          uuid: actaUuid,
          latitud: state.latitud!,
          longitud: state.longitud!,
          ppu: ppu,
          nombreInfractor: Value(nombreInfractor), 
          rutInfractor: Value(rutInfractor),       
          tipoVehiculo: tipoVehiculo,
          colorVehiculo: colorVehiculo,
          marcaVehiculo: marcaVehiculo,
          tipoInfraccionId: tipoInfraccionId ?? 1, 
          observaciones: observaciones,
          inspectorId: _inspectorId, 
          estadoActa: 'PENDIENTE_SYNC',
          deviceId: 'MOCK_DEVICE_ID',
          firmaRechazo: Value(firmaRechazo),
        ),
      );

      for (var foto in state.fotosConHash) {
        await _db.into(_db.evidenciasFotograficas).insert(
          EvidenciasFotograficasCompanion.insert(
            id: const Uuid().v4(),
            actaUuid: actaUuid,
            rutaLocal: foto['path']!,
            hashIntegridad: foto['hash']!,
          ),
        );
      }
    });

    state = FormularioState(); // Reset
  }
}

final formularioInfraccionProvider = StateNotifierProvider<FormularioInfraccionNotifier, FormularioState>((ref) {
  return FormularioInfraccionNotifier(ref.watch(databaseProvider));
});
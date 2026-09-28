// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ActasInfraccionTable extends ActasInfraccion
    with TableInfo<$ActasInfraccionTable, ActasInfraccionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActasInfraccionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _latitudMeta =
      const VerificationMeta('latitud');
  @override
  late final GeneratedColumn<double> latitud = GeneratedColumn<double>(
      'latitud', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudMeta =
      const VerificationMeta('longitud');
  @override
  late final GeneratedColumn<double> longitud = GeneratedColumn<double>(
      'longitud', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _direccionFallbackMeta =
      const VerificationMeta('direccionFallback');
  @override
  late final GeneratedColumn<String> direccionFallback =
      GeneratedColumn<String>('direccion_fallback', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ppuMeta = const VerificationMeta('ppu');
  @override
  late final GeneratedColumn<String> ppu = GeneratedColumn<String>(
      'ppu', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreInfractorMeta =
      const VerificationMeta('nombreInfractor');
  @override
  late final GeneratedColumn<String> nombreInfractor = GeneratedColumn<String>(
      'nombre_infractor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rutInfractorMeta =
      const VerificationMeta('rutInfractor');
  @override
  late final GeneratedColumn<String> rutInfractor = GeneratedColumn<String>(
      'rut_infractor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoVehiculoMeta =
      const VerificationMeta('tipoVehiculo');
  @override
  late final GeneratedColumn<String> tipoVehiculo = GeneratedColumn<String>(
      'tipo_vehiculo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorVehiculoMeta =
      const VerificationMeta('colorVehiculo');
  @override
  late final GeneratedColumn<String> colorVehiculo = GeneratedColumn<String>(
      'color_vehiculo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _marcaVehiculoMeta =
      const VerificationMeta('marcaVehiculo');
  @override
  late final GeneratedColumn<String> marcaVehiculo = GeneratedColumn<String>(
      'marca_vehiculo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoInfraccionIdMeta =
      const VerificationMeta('tipoInfraccionId');
  @override
  late final GeneratedColumn<int> tipoInfraccionId = GeneratedColumn<int>(
      'tipo_infraccion_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _inspectorIdMeta =
      const VerificationMeta('inspectorId');
  @override
  late final GeneratedColumn<int> inspectorId = GeneratedColumn<int>(
      'inspector_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estadoActaMeta =
      const VerificationMeta('estadoActa');
  @override
  late final GeneratedColumn<String> estadoActa = GeneratedColumn<String>(
      'estado_acta', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firmaRechazoMeta =
      const VerificationMeta('firmaRechazo');
  @override
  late final GeneratedColumn<bool> firmaRechazo = GeneratedColumn<bool>(
      'firma_rechazo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("firma_rechazo" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        createdAt,
        latitud,
        longitud,
        direccionFallback,
        ppu,
        nombreInfractor,
        rutInfractor,
        tipoVehiculo,
        colorVehiculo,
        marcaVehiculo,
        tipoInfraccionId,
        observaciones,
        inspectorId,
        estadoActa,
        syncedAt,
        deviceId,
        firmaRechazo
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'actas_infraccion';
  @override
  VerificationContext validateIntegrity(
      Insertable<ActasInfraccionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('latitud')) {
      context.handle(_latitudMeta,
          latitud.isAcceptableOrUnknown(data['latitud']!, _latitudMeta));
    } else if (isInserting) {
      context.missing(_latitudMeta);
    }
    if (data.containsKey('longitud')) {
      context.handle(_longitudMeta,
          longitud.isAcceptableOrUnknown(data['longitud']!, _longitudMeta));
    } else if (isInserting) {
      context.missing(_longitudMeta);
    }
    if (data.containsKey('direccion_fallback')) {
      context.handle(
          _direccionFallbackMeta,
          direccionFallback.isAcceptableOrUnknown(
              data['direccion_fallback']!, _direccionFallbackMeta));
    }
    if (data.containsKey('ppu')) {
      context.handle(
          _ppuMeta, ppu.isAcceptableOrUnknown(data['ppu']!, _ppuMeta));
    } else if (isInserting) {
      context.missing(_ppuMeta);
    }
    if (data.containsKey('nombre_infractor')) {
      context.handle(
          _nombreInfractorMeta,
          nombreInfractor.isAcceptableOrUnknown(
              data['nombre_infractor']!, _nombreInfractorMeta));
    }
    if (data.containsKey('rut_infractor')) {
      context.handle(
          _rutInfractorMeta,
          rutInfractor.isAcceptableOrUnknown(
              data['rut_infractor']!, _rutInfractorMeta));
    }
    if (data.containsKey('tipo_vehiculo')) {
      context.handle(
          _tipoVehiculoMeta,
          tipoVehiculo.isAcceptableOrUnknown(
              data['tipo_vehiculo']!, _tipoVehiculoMeta));
    } else if (isInserting) {
      context.missing(_tipoVehiculoMeta);
    }
    if (data.containsKey('color_vehiculo')) {
      context.handle(
          _colorVehiculoMeta,
          colorVehiculo.isAcceptableOrUnknown(
              data['color_vehiculo']!, _colorVehiculoMeta));
    } else if (isInserting) {
      context.missing(_colorVehiculoMeta);
    }
    if (data.containsKey('marca_vehiculo')) {
      context.handle(
          _marcaVehiculoMeta,
          marcaVehiculo.isAcceptableOrUnknown(
              data['marca_vehiculo']!, _marcaVehiculoMeta));
    } else if (isInserting) {
      context.missing(_marcaVehiculoMeta);
    }
    if (data.containsKey('tipo_infraccion_id')) {
      context.handle(
          _tipoInfraccionIdMeta,
          tipoInfraccionId.isAcceptableOrUnknown(
              data['tipo_infraccion_id']!, _tipoInfraccionIdMeta));
    } else if (isInserting) {
      context.missing(_tipoInfraccionIdMeta);
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    } else if (isInserting) {
      context.missing(_observacionesMeta);
    }
    if (data.containsKey('inspector_id')) {
      context.handle(
          _inspectorIdMeta,
          inspectorId.isAcceptableOrUnknown(
              data['inspector_id']!, _inspectorIdMeta));
    } else if (isInserting) {
      context.missing(_inspectorIdMeta);
    }
    if (data.containsKey('estado_acta')) {
      context.handle(
          _estadoActaMeta,
          estadoActa.isAcceptableOrUnknown(
              data['estado_acta']!, _estadoActaMeta));
    } else if (isInserting) {
      context.missing(_estadoActaMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('firma_rechazo')) {
      context.handle(
          _firmaRechazoMeta,
          firmaRechazo.isAcceptableOrUnknown(
              data['firma_rechazo']!, _firmaRechazoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  ActasInfraccionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActasInfraccionData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      latitud: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitud'])!,
      longitud: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitud'])!,
      direccionFallback: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}direccion_fallback']),
      ppu: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ppu'])!,
      nombreInfractor: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nombre_infractor']),
      rutInfractor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rut_infractor']),
      tipoVehiculo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_vehiculo'])!,
      colorVehiculo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_vehiculo'])!,
      marcaVehiculo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca_vehiculo'])!,
      tipoInfraccionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}tipo_infraccion_id'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones'])!,
      inspectorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}inspector_id'])!,
      estadoActa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado_acta'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      firmaRechazo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}firma_rechazo'])!,
    );
  }

  @override
  $ActasInfraccionTable createAlias(String alias) {
    return $ActasInfraccionTable(attachedDatabase, alias);
  }
}

class ActasInfraccionData extends DataClass
    implements Insertable<ActasInfraccionData> {
  final String uuid;
  final DateTime createdAt;
  final double latitud;
  final double longitud;
  final String? direccionFallback;
  final String ppu;
  final String? nombreInfractor;
  final String? rutInfractor;
  final String tipoVehiculo;
  final String colorVehiculo;
  final String marcaVehiculo;
  final int tipoInfraccionId;
  final String observaciones;
  final int inspectorId;
  final String estadoActa;
  final DateTime? syncedAt;
  final String deviceId;
  final bool firmaRechazo;
  const ActasInfraccionData(
      {required this.uuid,
      required this.createdAt,
      required this.latitud,
      required this.longitud,
      this.direccionFallback,
      required this.ppu,
      this.nombreInfractor,
      this.rutInfractor,
      required this.tipoVehiculo,
      required this.colorVehiculo,
      required this.marcaVehiculo,
      required this.tipoInfraccionId,
      required this.observaciones,
      required this.inspectorId,
      required this.estadoActa,
      this.syncedAt,
      required this.deviceId,
      required this.firmaRechazo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['latitud'] = Variable<double>(latitud);
    map['longitud'] = Variable<double>(longitud);
    if (!nullToAbsent || direccionFallback != null) {
      map['direccion_fallback'] = Variable<String>(direccionFallback);
    }
    map['ppu'] = Variable<String>(ppu);
    if (!nullToAbsent || nombreInfractor != null) {
      map['nombre_infractor'] = Variable<String>(nombreInfractor);
    }
    if (!nullToAbsent || rutInfractor != null) {
      map['rut_infractor'] = Variable<String>(rutInfractor);
    }
    map['tipo_vehiculo'] = Variable<String>(tipoVehiculo);
    map['color_vehiculo'] = Variable<String>(colorVehiculo);
    map['marca_vehiculo'] = Variable<String>(marcaVehiculo);
    map['tipo_infraccion_id'] = Variable<int>(tipoInfraccionId);
    map['observaciones'] = Variable<String>(observaciones);
    map['inspector_id'] = Variable<int>(inspectorId);
    map['estado_acta'] = Variable<String>(estadoActa);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['device_id'] = Variable<String>(deviceId);
    map['firma_rechazo'] = Variable<bool>(firmaRechazo);
    return map;
  }

  ActasInfraccionCompanion toCompanion(bool nullToAbsent) {
    return ActasInfraccionCompanion(
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      latitud: Value(latitud),
      longitud: Value(longitud),
      direccionFallback: direccionFallback == null && nullToAbsent
          ? const Value.absent()
          : Value(direccionFallback),
      ppu: Value(ppu),
      nombreInfractor: nombreInfractor == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreInfractor),
      rutInfractor: rutInfractor == null && nullToAbsent
          ? const Value.absent()
          : Value(rutInfractor),
      tipoVehiculo: Value(tipoVehiculo),
      colorVehiculo: Value(colorVehiculo),
      marcaVehiculo: Value(marcaVehiculo),
      tipoInfraccionId: Value(tipoInfraccionId),
      observaciones: Value(observaciones),
      inspectorId: Value(inspectorId),
      estadoActa: Value(estadoActa),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      deviceId: Value(deviceId),
      firmaRechazo: Value(firmaRechazo),
    );
  }

  factory ActasInfraccionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActasInfraccionData(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      latitud: serializer.fromJson<double>(json['latitud']),
      longitud: serializer.fromJson<double>(json['longitud']),
      direccionFallback:
          serializer.fromJson<String?>(json['direccionFallback']),
      ppu: serializer.fromJson<String>(json['ppu']),
      nombreInfractor: serializer.fromJson<String?>(json['nombreInfractor']),
      rutInfractor: serializer.fromJson<String?>(json['rutInfractor']),
      tipoVehiculo: serializer.fromJson<String>(json['tipoVehiculo']),
      colorVehiculo: serializer.fromJson<String>(json['colorVehiculo']),
      marcaVehiculo: serializer.fromJson<String>(json['marcaVehiculo']),
      tipoInfraccionId: serializer.fromJson<int>(json['tipoInfraccionId']),
      observaciones: serializer.fromJson<String>(json['observaciones']),
      inspectorId: serializer.fromJson<int>(json['inspectorId']),
      estadoActa: serializer.fromJson<String>(json['estadoActa']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      firmaRechazo: serializer.fromJson<bool>(json['firmaRechazo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'latitud': serializer.toJson<double>(latitud),
      'longitud': serializer.toJson<double>(longitud),
      'direccionFallback': serializer.toJson<String?>(direccionFallback),
      'ppu': serializer.toJson<String>(ppu),
      'nombreInfractor': serializer.toJson<String?>(nombreInfractor),
      'rutInfractor': serializer.toJson<String?>(rutInfractor),
      'tipoVehiculo': serializer.toJson<String>(tipoVehiculo),
      'colorVehiculo': serializer.toJson<String>(colorVehiculo),
      'marcaVehiculo': serializer.toJson<String>(marcaVehiculo),
      'tipoInfraccionId': serializer.toJson<int>(tipoInfraccionId),
      'observaciones': serializer.toJson<String>(observaciones),
      'inspectorId': serializer.toJson<int>(inspectorId),
      'estadoActa': serializer.toJson<String>(estadoActa),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'firmaRechazo': serializer.toJson<bool>(firmaRechazo),
    };
  }

  ActasInfraccionData copyWith(
          {String? uuid,
          DateTime? createdAt,
          double? latitud,
          double? longitud,
          Value<String?> direccionFallback = const Value.absent(),
          String? ppu,
          Value<String?> nombreInfractor = const Value.absent(),
          Value<String?> rutInfractor = const Value.absent(),
          String? tipoVehiculo,
          String? colorVehiculo,
          String? marcaVehiculo,
          int? tipoInfraccionId,
          String? observaciones,
          int? inspectorId,
          String? estadoActa,
          Value<DateTime?> syncedAt = const Value.absent(),
          String? deviceId,
          bool? firmaRechazo}) =>
      ActasInfraccionData(
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        direccionFallback: direccionFallback.present
            ? direccionFallback.value
            : this.direccionFallback,
        ppu: ppu ?? this.ppu,
        nombreInfractor: nombreInfractor.present
            ? nombreInfractor.value
            : this.nombreInfractor,
        rutInfractor:
            rutInfractor.present ? rutInfractor.value : this.rutInfractor,
        tipoVehiculo: tipoVehiculo ?? this.tipoVehiculo,
        colorVehiculo: colorVehiculo ?? this.colorVehiculo,
        marcaVehiculo: marcaVehiculo ?? this.marcaVehiculo,
        tipoInfraccionId: tipoInfraccionId ?? this.tipoInfraccionId,
        observaciones: observaciones ?? this.observaciones,
        inspectorId: inspectorId ?? this.inspectorId,
        estadoActa: estadoActa ?? this.estadoActa,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        deviceId: deviceId ?? this.deviceId,
        firmaRechazo: firmaRechazo ?? this.firmaRechazo,
      );
  ActasInfraccionData copyWithCompanion(ActasInfraccionCompanion data) {
    return ActasInfraccionData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      latitud: data.latitud.present ? data.latitud.value : this.latitud,
      longitud: data.longitud.present ? data.longitud.value : this.longitud,
      direccionFallback: data.direccionFallback.present
          ? data.direccionFallback.value
          : this.direccionFallback,
      ppu: data.ppu.present ? data.ppu.value : this.ppu,
      nombreInfractor: data.nombreInfractor.present
          ? data.nombreInfractor.value
          : this.nombreInfractor,
      rutInfractor: data.rutInfractor.present
          ? data.rutInfractor.value
          : this.rutInfractor,
      tipoVehiculo: data.tipoVehiculo.present
          ? data.tipoVehiculo.value
          : this.tipoVehiculo,
      colorVehiculo: data.colorVehiculo.present
          ? data.colorVehiculo.value
          : this.colorVehiculo,
      marcaVehiculo: data.marcaVehiculo.present
          ? data.marcaVehiculo.value
          : this.marcaVehiculo,
      tipoInfraccionId: data.tipoInfraccionId.present
          ? data.tipoInfraccionId.value
          : this.tipoInfraccionId,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      inspectorId:
          data.inspectorId.present ? data.inspectorId.value : this.inspectorId,
      estadoActa:
          data.estadoActa.present ? data.estadoActa.value : this.estadoActa,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      firmaRechazo: data.firmaRechazo.present
          ? data.firmaRechazo.value
          : this.firmaRechazo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActasInfraccionData(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('direccionFallback: $direccionFallback, ')
          ..write('ppu: $ppu, ')
          ..write('nombreInfractor: $nombreInfractor, ')
          ..write('rutInfractor: $rutInfractor, ')
          ..write('tipoVehiculo: $tipoVehiculo, ')
          ..write('colorVehiculo: $colorVehiculo, ')
          ..write('marcaVehiculo: $marcaVehiculo, ')
          ..write('tipoInfraccionId: $tipoInfraccionId, ')
          ..write('observaciones: $observaciones, ')
          ..write('inspectorId: $inspectorId, ')
          ..write('estadoActa: $estadoActa, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('firmaRechazo: $firmaRechazo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid,
      createdAt,
      latitud,
      longitud,
      direccionFallback,
      ppu,
      nombreInfractor,
      rutInfractor,
      tipoVehiculo,
      colorVehiculo,
      marcaVehiculo,
      tipoInfraccionId,
      observaciones,
      inspectorId,
      estadoActa,
      syncedAt,
      deviceId,
      firmaRechazo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActasInfraccionData &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.latitud == this.latitud &&
          other.longitud == this.longitud &&
          other.direccionFallback == this.direccionFallback &&
          other.ppu == this.ppu &&
          other.nombreInfractor == this.nombreInfractor &&
          other.rutInfractor == this.rutInfractor &&
          other.tipoVehiculo == this.tipoVehiculo &&
          other.colorVehiculo == this.colorVehiculo &&
          other.marcaVehiculo == this.marcaVehiculo &&
          other.tipoInfraccionId == this.tipoInfraccionId &&
          other.observaciones == this.observaciones &&
          other.inspectorId == this.inspectorId &&
          other.estadoActa == this.estadoActa &&
          other.syncedAt == this.syncedAt &&
          other.deviceId == this.deviceId &&
          other.firmaRechazo == this.firmaRechazo);
}

class ActasInfraccionCompanion extends UpdateCompanion<ActasInfraccionData> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<double> latitud;
  final Value<double> longitud;
  final Value<String?> direccionFallback;
  final Value<String> ppu;
  final Value<String?> nombreInfractor;
  final Value<String?> rutInfractor;
  final Value<String> tipoVehiculo;
  final Value<String> colorVehiculo;
  final Value<String> marcaVehiculo;
  final Value<int> tipoInfraccionId;
  final Value<String> observaciones;
  final Value<int> inspectorId;
  final Value<String> estadoActa;
  final Value<DateTime?> syncedAt;
  final Value<String> deviceId;
  final Value<bool> firmaRechazo;
  final Value<int> rowid;
  const ActasInfraccionCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.direccionFallback = const Value.absent(),
    this.ppu = const Value.absent(),
    this.nombreInfractor = const Value.absent(),
    this.rutInfractor = const Value.absent(),
    this.tipoVehiculo = const Value.absent(),
    this.colorVehiculo = const Value.absent(),
    this.marcaVehiculo = const Value.absent(),
    this.tipoInfraccionId = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.inspectorId = const Value.absent(),
    this.estadoActa = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.firmaRechazo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActasInfraccionCompanion.insert({
    required String uuid,
    this.createdAt = const Value.absent(),
    required double latitud,
    required double longitud,
    this.direccionFallback = const Value.absent(),
    required String ppu,
    this.nombreInfractor = const Value.absent(),
    this.rutInfractor = const Value.absent(),
    required String tipoVehiculo,
    required String colorVehiculo,
    required String marcaVehiculo,
    required int tipoInfraccionId,
    required String observaciones,
    required int inspectorId,
    required String estadoActa,
    this.syncedAt = const Value.absent(),
    required String deviceId,
    this.firmaRechazo = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        latitud = Value(latitud),
        longitud = Value(longitud),
        ppu = Value(ppu),
        tipoVehiculo = Value(tipoVehiculo),
        colorVehiculo = Value(colorVehiculo),
        marcaVehiculo = Value(marcaVehiculo),
        tipoInfraccionId = Value(tipoInfraccionId),
        observaciones = Value(observaciones),
        inspectorId = Value(inspectorId),
        estadoActa = Value(estadoActa),
        deviceId = Value(deviceId);
  static Insertable<ActasInfraccionData> custom({
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<double>? latitud,
    Expression<double>? longitud,
    Expression<String>? direccionFallback,
    Expression<String>? ppu,
    Expression<String>? nombreInfractor,
    Expression<String>? rutInfractor,
    Expression<String>? tipoVehiculo,
    Expression<String>? colorVehiculo,
    Expression<String>? marcaVehiculo,
    Expression<int>? tipoInfraccionId,
    Expression<String>? observaciones,
    Expression<int>? inspectorId,
    Expression<String>? estadoActa,
    Expression<DateTime>? syncedAt,
    Expression<String>? deviceId,
    Expression<bool>? firmaRechazo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (latitud != null) 'latitud': latitud,
      if (longitud != null) 'longitud': longitud,
      if (direccionFallback != null) 'direccion_fallback': direccionFallback,
      if (ppu != null) 'ppu': ppu,
      if (nombreInfractor != null) 'nombre_infractor': nombreInfractor,
      if (rutInfractor != null) 'rut_infractor': rutInfractor,
      if (tipoVehiculo != null) 'tipo_vehiculo': tipoVehiculo,
      if (colorVehiculo != null) 'color_vehiculo': colorVehiculo,
      if (marcaVehiculo != null) 'marca_vehiculo': marcaVehiculo,
      if (tipoInfraccionId != null) 'tipo_infraccion_id': tipoInfraccionId,
      if (observaciones != null) 'observaciones': observaciones,
      if (inspectorId != null) 'inspector_id': inspectorId,
      if (estadoActa != null) 'estado_acta': estadoActa,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (firmaRechazo != null) 'firma_rechazo': firmaRechazo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActasInfraccionCompanion copyWith(
      {Value<String>? uuid,
      Value<DateTime>? createdAt,
      Value<double>? latitud,
      Value<double>? longitud,
      Value<String?>? direccionFallback,
      Value<String>? ppu,
      Value<String?>? nombreInfractor,
      Value<String?>? rutInfractor,
      Value<String>? tipoVehiculo,
      Value<String>? colorVehiculo,
      Value<String>? marcaVehiculo,
      Value<int>? tipoInfraccionId,
      Value<String>? observaciones,
      Value<int>? inspectorId,
      Value<String>? estadoActa,
      Value<DateTime?>? syncedAt,
      Value<String>? deviceId,
      Value<bool>? firmaRechazo,
      Value<int>? rowid}) {
    return ActasInfraccionCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      direccionFallback: direccionFallback ?? this.direccionFallback,
      ppu: ppu ?? this.ppu,
      nombreInfractor: nombreInfractor ?? this.nombreInfractor,
      rutInfractor: rutInfractor ?? this.rutInfractor,
      tipoVehiculo: tipoVehiculo ?? this.tipoVehiculo,
      colorVehiculo: colorVehiculo ?? this.colorVehiculo,
      marcaVehiculo: marcaVehiculo ?? this.marcaVehiculo,
      tipoInfraccionId: tipoInfraccionId ?? this.tipoInfraccionId,
      observaciones: observaciones ?? this.observaciones,
      inspectorId: inspectorId ?? this.inspectorId,
      estadoActa: estadoActa ?? this.estadoActa,
      syncedAt: syncedAt ?? this.syncedAt,
      deviceId: deviceId ?? this.deviceId,
      firmaRechazo: firmaRechazo ?? this.firmaRechazo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (latitud.present) {
      map['latitud'] = Variable<double>(latitud.value);
    }
    if (longitud.present) {
      map['longitud'] = Variable<double>(longitud.value);
    }
    if (direccionFallback.present) {
      map['direccion_fallback'] = Variable<String>(direccionFallback.value);
    }
    if (ppu.present) {
      map['ppu'] = Variable<String>(ppu.value);
    }
    if (nombreInfractor.present) {
      map['nombre_infractor'] = Variable<String>(nombreInfractor.value);
    }
    if (rutInfractor.present) {
      map['rut_infractor'] = Variable<String>(rutInfractor.value);
    }
    if (tipoVehiculo.present) {
      map['tipo_vehiculo'] = Variable<String>(tipoVehiculo.value);
    }
    if (colorVehiculo.present) {
      map['color_vehiculo'] = Variable<String>(colorVehiculo.value);
    }
    if (marcaVehiculo.present) {
      map['marca_vehiculo'] = Variable<String>(marcaVehiculo.value);
    }
    if (tipoInfraccionId.present) {
      map['tipo_infraccion_id'] = Variable<int>(tipoInfraccionId.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (inspectorId.present) {
      map['inspector_id'] = Variable<int>(inspectorId.value);
    }
    if (estadoActa.present) {
      map['estado_acta'] = Variable<String>(estadoActa.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (firmaRechazo.present) {
      map['firma_rechazo'] = Variable<bool>(firmaRechazo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActasInfraccionCompanion(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('direccionFallback: $direccionFallback, ')
          ..write('ppu: $ppu, ')
          ..write('nombreInfractor: $nombreInfractor, ')
          ..write('rutInfractor: $rutInfractor, ')
          ..write('tipoVehiculo: $tipoVehiculo, ')
          ..write('colorVehiculo: $colorVehiculo, ')
          ..write('marcaVehiculo: $marcaVehiculo, ')
          ..write('tipoInfraccionId: $tipoInfraccionId, ')
          ..write('observaciones: $observaciones, ')
          ..write('inspectorId: $inspectorId, ')
          ..write('estadoActa: $estadoActa, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('firmaRechazo: $firmaRechazo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvidenciasFotograficasTable extends EvidenciasFotograficas
    with TableInfo<$EvidenciasFotograficasTable, EvidenciasFotografica> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvidenciasFotograficasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _actaUuidMeta =
      const VerificationMeta('actaUuid');
  @override
  late final GeneratedColumn<String> actaUuid = GeneratedColumn<String>(
      'acta_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rutaLocalMeta =
      const VerificationMeta('rutaLocal');
  @override
  late final GeneratedColumn<String> rutaLocal = GeneratedColumn<String>(
      'ruta_local', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hashIntegridadMeta =
      const VerificationMeta('hashIntegridad');
  @override
  late final GeneratedColumn<String> hashIntegridad = GeneratedColumn<String>(
      'hash_integridad', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, actaUuid, rutaLocal, hashIntegridad, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evidencias_fotograficas';
  @override
  VerificationContext validateIntegrity(
      Insertable<EvidenciasFotografica> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('acta_uuid')) {
      context.handle(_actaUuidMeta,
          actaUuid.isAcceptableOrUnknown(data['acta_uuid']!, _actaUuidMeta));
    } else if (isInserting) {
      context.missing(_actaUuidMeta);
    }
    if (data.containsKey('ruta_local')) {
      context.handle(_rutaLocalMeta,
          rutaLocal.isAcceptableOrUnknown(data['ruta_local']!, _rutaLocalMeta));
    } else if (isInserting) {
      context.missing(_rutaLocalMeta);
    }
    if (data.containsKey('hash_integridad')) {
      context.handle(
          _hashIntegridadMeta,
          hashIntegridad.isAcceptableOrUnknown(
              data['hash_integridad']!, _hashIntegridadMeta));
    } else if (isInserting) {
      context.missing(_hashIntegridadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvidenciasFotografica map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvidenciasFotografica(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      actaUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}acta_uuid'])!,
      rutaLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ruta_local'])!,
      hashIntegridad: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}hash_integridad'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $EvidenciasFotograficasTable createAlias(String alias) {
    return $EvidenciasFotograficasTable(attachedDatabase, alias);
  }
}

class EvidenciasFotografica extends DataClass
    implements Insertable<EvidenciasFotografica> {
  final String id;
  final String actaUuid;
  final String rutaLocal;
  final String hashIntegridad;
  final DateTime createdAt;
  const EvidenciasFotografica(
      {required this.id,
      required this.actaUuid,
      required this.rutaLocal,
      required this.hashIntegridad,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['acta_uuid'] = Variable<String>(actaUuid);
    map['ruta_local'] = Variable<String>(rutaLocal);
    map['hash_integridad'] = Variable<String>(hashIntegridad);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EvidenciasFotograficasCompanion toCompanion(bool nullToAbsent) {
    return EvidenciasFotograficasCompanion(
      id: Value(id),
      actaUuid: Value(actaUuid),
      rutaLocal: Value(rutaLocal),
      hashIntegridad: Value(hashIntegridad),
      createdAt: Value(createdAt),
    );
  }

  factory EvidenciasFotografica.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvidenciasFotografica(
      id: serializer.fromJson<String>(json['id']),
      actaUuid: serializer.fromJson<String>(json['actaUuid']),
      rutaLocal: serializer.fromJson<String>(json['rutaLocal']),
      hashIntegridad: serializer.fromJson<String>(json['hashIntegridad']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'actaUuid': serializer.toJson<String>(actaUuid),
      'rutaLocal': serializer.toJson<String>(rutaLocal),
      'hashIntegridad': serializer.toJson<String>(hashIntegridad),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EvidenciasFotografica copyWith(
          {String? id,
          String? actaUuid,
          String? rutaLocal,
          String? hashIntegridad,
          DateTime? createdAt}) =>
      EvidenciasFotografica(
        id: id ?? this.id,
        actaUuid: actaUuid ?? this.actaUuid,
        rutaLocal: rutaLocal ?? this.rutaLocal,
        hashIntegridad: hashIntegridad ?? this.hashIntegridad,
        createdAt: createdAt ?? this.createdAt,
      );
  EvidenciasFotografica copyWithCompanion(
      EvidenciasFotograficasCompanion data) {
    return EvidenciasFotografica(
      id: data.id.present ? data.id.value : this.id,
      actaUuid: data.actaUuid.present ? data.actaUuid.value : this.actaUuid,
      rutaLocal: data.rutaLocal.present ? data.rutaLocal.value : this.rutaLocal,
      hashIntegridad: data.hashIntegridad.present
          ? data.hashIntegridad.value
          : this.hashIntegridad,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvidenciasFotografica(')
          ..write('id: $id, ')
          ..write('actaUuid: $actaUuid, ')
          ..write('rutaLocal: $rutaLocal, ')
          ..write('hashIntegridad: $hashIntegridad, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, actaUuid, rutaLocal, hashIntegridad, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvidenciasFotografica &&
          other.id == this.id &&
          other.actaUuid == this.actaUuid &&
          other.rutaLocal == this.rutaLocal &&
          other.hashIntegridad == this.hashIntegridad &&
          other.createdAt == this.createdAt);
}

class EvidenciasFotograficasCompanion
    extends UpdateCompanion<EvidenciasFotografica> {
  final Value<String> id;
  final Value<String> actaUuid;
  final Value<String> rutaLocal;
  final Value<String> hashIntegridad;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const EvidenciasFotograficasCompanion({
    this.id = const Value.absent(),
    this.actaUuid = const Value.absent(),
    this.rutaLocal = const Value.absent(),
    this.hashIntegridad = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EvidenciasFotograficasCompanion.insert({
    required String id,
    required String actaUuid,
    required String rutaLocal,
    required String hashIntegridad,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        actaUuid = Value(actaUuid),
        rutaLocal = Value(rutaLocal),
        hashIntegridad = Value(hashIntegridad);
  static Insertable<EvidenciasFotografica> custom({
    Expression<String>? id,
    Expression<String>? actaUuid,
    Expression<String>? rutaLocal,
    Expression<String>? hashIntegridad,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actaUuid != null) 'acta_uuid': actaUuid,
      if (rutaLocal != null) 'ruta_local': rutaLocal,
      if (hashIntegridad != null) 'hash_integridad': hashIntegridad,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EvidenciasFotograficasCompanion copyWith(
      {Value<String>? id,
      Value<String>? actaUuid,
      Value<String>? rutaLocal,
      Value<String>? hashIntegridad,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return EvidenciasFotograficasCompanion(
      id: id ?? this.id,
      actaUuid: actaUuid ?? this.actaUuid,
      rutaLocal: rutaLocal ?? this.rutaLocal,
      hashIntegridad: hashIntegridad ?? this.hashIntegridad,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (actaUuid.present) {
      map['acta_uuid'] = Variable<String>(actaUuid.value);
    }
    if (rutaLocal.present) {
      map['ruta_local'] = Variable<String>(rutaLocal.value);
    }
    if (hashIntegridad.present) {
      map['hash_integridad'] = Variable<String>(hashIntegridad.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvidenciasFotograficasCompanion(')
          ..write('id: $id, ')
          ..write('actaUuid: $actaUuid, ')
          ..write('rutaLocal: $rutaLocal, ')
          ..write('hashIntegridad: $hashIntegridad, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ActasInfraccionTable actasInfraccion =
      $ActasInfraccionTable(this);
  late final $EvidenciasFotograficasTable evidenciasFotograficas =
      $EvidenciasFotograficasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [actasInfraccion, evidenciasFotograficas];
}

typedef $$ActasInfraccionTableCreateCompanionBuilder = ActasInfraccionCompanion
    Function({
  required String uuid,
  Value<DateTime> createdAt,
  required double latitud,
  required double longitud,
  Value<String?> direccionFallback,
  required String ppu,
  Value<String?> nombreInfractor,
  Value<String?> rutInfractor,
  required String tipoVehiculo,
  required String colorVehiculo,
  required String marcaVehiculo,
  required int tipoInfraccionId,
  required String observaciones,
  required int inspectorId,
  required String estadoActa,
  Value<DateTime?> syncedAt,
  required String deviceId,
  Value<bool> firmaRechazo,
  Value<int> rowid,
});
typedef $$ActasInfraccionTableUpdateCompanionBuilder = ActasInfraccionCompanion
    Function({
  Value<String> uuid,
  Value<DateTime> createdAt,
  Value<double> latitud,
  Value<double> longitud,
  Value<String?> direccionFallback,
  Value<String> ppu,
  Value<String?> nombreInfractor,
  Value<String?> rutInfractor,
  Value<String> tipoVehiculo,
  Value<String> colorVehiculo,
  Value<String> marcaVehiculo,
  Value<int> tipoInfraccionId,
  Value<String> observaciones,
  Value<int> inspectorId,
  Value<String> estadoActa,
  Value<DateTime?> syncedAt,
  Value<String> deviceId,
  Value<bool> firmaRechazo,
  Value<int> rowid,
});

class $$ActasInfraccionTableFilterComposer
    extends Composer<_$AppDatabase, $ActasInfraccionTable> {
  $$ActasInfraccionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitud => $composableBuilder(
      column: $table.latitud, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitud => $composableBuilder(
      column: $table.longitud, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direccionFallback => $composableBuilder(
      column: $table.direccionFallback,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ppu => $composableBuilder(
      column: $table.ppu, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreInfractor => $composableBuilder(
      column: $table.nombreInfractor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rutInfractor => $composableBuilder(
      column: $table.rutInfractor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoVehiculo => $composableBuilder(
      column: $table.tipoVehiculo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorVehiculo => $composableBuilder(
      column: $table.colorVehiculo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marcaVehiculo => $composableBuilder(
      column: $table.marcaVehiculo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tipoInfraccionId => $composableBuilder(
      column: $table.tipoInfraccionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get inspectorId => $composableBuilder(
      column: $table.inspectorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estadoActa => $composableBuilder(
      column: $table.estadoActa, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get firmaRechazo => $composableBuilder(
      column: $table.firmaRechazo, builder: (column) => ColumnFilters(column));
}

class $$ActasInfraccionTableOrderingComposer
    extends Composer<_$AppDatabase, $ActasInfraccionTable> {
  $$ActasInfraccionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitud => $composableBuilder(
      column: $table.latitud, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitud => $composableBuilder(
      column: $table.longitud, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direccionFallback => $composableBuilder(
      column: $table.direccionFallback,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ppu => $composableBuilder(
      column: $table.ppu, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreInfractor => $composableBuilder(
      column: $table.nombreInfractor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rutInfractor => $composableBuilder(
      column: $table.rutInfractor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoVehiculo => $composableBuilder(
      column: $table.tipoVehiculo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorVehiculo => $composableBuilder(
      column: $table.colorVehiculo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marcaVehiculo => $composableBuilder(
      column: $table.marcaVehiculo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tipoInfraccionId => $composableBuilder(
      column: $table.tipoInfraccionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get inspectorId => $composableBuilder(
      column: $table.inspectorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estadoActa => $composableBuilder(
      column: $table.estadoActa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get firmaRechazo => $composableBuilder(
      column: $table.firmaRechazo,
      builder: (column) => ColumnOrderings(column));
}

class $$ActasInfraccionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActasInfraccionTable> {
  $$ActasInfraccionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get latitud =>
      $composableBuilder(column: $table.latitud, builder: (column) => column);

  GeneratedColumn<double> get longitud =>
      $composableBuilder(column: $table.longitud, builder: (column) => column);

  GeneratedColumn<String> get direccionFallback => $composableBuilder(
      column: $table.direccionFallback, builder: (column) => column);

  GeneratedColumn<String> get ppu =>
      $composableBuilder(column: $table.ppu, builder: (column) => column);

  GeneratedColumn<String> get nombreInfractor => $composableBuilder(
      column: $table.nombreInfractor, builder: (column) => column);

  GeneratedColumn<String> get rutInfractor => $composableBuilder(
      column: $table.rutInfractor, builder: (column) => column);

  GeneratedColumn<String> get tipoVehiculo => $composableBuilder(
      column: $table.tipoVehiculo, builder: (column) => column);

  GeneratedColumn<String> get colorVehiculo => $composableBuilder(
      column: $table.colorVehiculo, builder: (column) => column);

  GeneratedColumn<String> get marcaVehiculo => $composableBuilder(
      column: $table.marcaVehiculo, builder: (column) => column);

  GeneratedColumn<int> get tipoInfraccionId => $composableBuilder(
      column: $table.tipoInfraccionId, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<int> get inspectorId => $composableBuilder(
      column: $table.inspectorId, builder: (column) => column);

  GeneratedColumn<String> get estadoActa => $composableBuilder(
      column: $table.estadoActa, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<bool> get firmaRechazo => $composableBuilder(
      column: $table.firmaRechazo, builder: (column) => column);
}

class $$ActasInfraccionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActasInfraccionTable,
    ActasInfraccionData,
    $$ActasInfraccionTableFilterComposer,
    $$ActasInfraccionTableOrderingComposer,
    $$ActasInfraccionTableAnnotationComposer,
    $$ActasInfraccionTableCreateCompanionBuilder,
    $$ActasInfraccionTableUpdateCompanionBuilder,
    (
      ActasInfraccionData,
      BaseReferences<_$AppDatabase, $ActasInfraccionTable, ActasInfraccionData>
    ),
    ActasInfraccionData,
    PrefetchHooks Function()> {
  $$ActasInfraccionTableTableManager(
      _$AppDatabase db, $ActasInfraccionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActasInfraccionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActasInfraccionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActasInfraccionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<double> latitud = const Value.absent(),
            Value<double> longitud = const Value.absent(),
            Value<String?> direccionFallback = const Value.absent(),
            Value<String> ppu = const Value.absent(),
            Value<String?> nombreInfractor = const Value.absent(),
            Value<String?> rutInfractor = const Value.absent(),
            Value<String> tipoVehiculo = const Value.absent(),
            Value<String> colorVehiculo = const Value.absent(),
            Value<String> marcaVehiculo = const Value.absent(),
            Value<int> tipoInfraccionId = const Value.absent(),
            Value<String> observaciones = const Value.absent(),
            Value<int> inspectorId = const Value.absent(),
            Value<String> estadoActa = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String> deviceId = const Value.absent(),
            Value<bool> firmaRechazo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActasInfraccionCompanion(
            uuid: uuid,
            createdAt: createdAt,
            latitud: latitud,
            longitud: longitud,
            direccionFallback: direccionFallback,
            ppu: ppu,
            nombreInfractor: nombreInfractor,
            rutInfractor: rutInfractor,
            tipoVehiculo: tipoVehiculo,
            colorVehiculo: colorVehiculo,
            marcaVehiculo: marcaVehiculo,
            tipoInfraccionId: tipoInfraccionId,
            observaciones: observaciones,
            inspectorId: inspectorId,
            estadoActa: estadoActa,
            syncedAt: syncedAt,
            deviceId: deviceId,
            firmaRechazo: firmaRechazo,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uuid,
            Value<DateTime> createdAt = const Value.absent(),
            required double latitud,
            required double longitud,
            Value<String?> direccionFallback = const Value.absent(),
            required String ppu,
            Value<String?> nombreInfractor = const Value.absent(),
            Value<String?> rutInfractor = const Value.absent(),
            required String tipoVehiculo,
            required String colorVehiculo,
            required String marcaVehiculo,
            required int tipoInfraccionId,
            required String observaciones,
            required int inspectorId,
            required String estadoActa,
            Value<DateTime?> syncedAt = const Value.absent(),
            required String deviceId,
            Value<bool> firmaRechazo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActasInfraccionCompanion.insert(
            uuid: uuid,
            createdAt: createdAt,
            latitud: latitud,
            longitud: longitud,
            direccionFallback: direccionFallback,
            ppu: ppu,
            nombreInfractor: nombreInfractor,
            rutInfractor: rutInfractor,
            tipoVehiculo: tipoVehiculo,
            colorVehiculo: colorVehiculo,
            marcaVehiculo: marcaVehiculo,
            tipoInfraccionId: tipoInfraccionId,
            observaciones: observaciones,
            inspectorId: inspectorId,
            estadoActa: estadoActa,
            syncedAt: syncedAt,
            deviceId: deviceId,
            firmaRechazo: firmaRechazo,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ActasInfraccionTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActasInfraccionTable,
    ActasInfraccionData,
    $$ActasInfraccionTableFilterComposer,
    $$ActasInfraccionTableOrderingComposer,
    $$ActasInfraccionTableAnnotationComposer,
    $$ActasInfraccionTableCreateCompanionBuilder,
    $$ActasInfraccionTableUpdateCompanionBuilder,
    (
      ActasInfraccionData,
      BaseReferences<_$AppDatabase, $ActasInfraccionTable, ActasInfraccionData>
    ),
    ActasInfraccionData,
    PrefetchHooks Function()>;
typedef $$EvidenciasFotograficasTableCreateCompanionBuilder
    = EvidenciasFotograficasCompanion Function({
  required String id,
  required String actaUuid,
  required String rutaLocal,
  required String hashIntegridad,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$EvidenciasFotograficasTableUpdateCompanionBuilder
    = EvidenciasFotograficasCompanion Function({
  Value<String> id,
  Value<String> actaUuid,
  Value<String> rutaLocal,
  Value<String> hashIntegridad,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$EvidenciasFotograficasTableFilterComposer
    extends Composer<_$AppDatabase, $EvidenciasFotograficasTable> {
  $$EvidenciasFotograficasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actaUuid => $composableBuilder(
      column: $table.actaUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rutaLocal => $composableBuilder(
      column: $table.rutaLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hashIntegridad => $composableBuilder(
      column: $table.hashIntegridad,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$EvidenciasFotograficasTableOrderingComposer
    extends Composer<_$AppDatabase, $EvidenciasFotograficasTable> {
  $$EvidenciasFotograficasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actaUuid => $composableBuilder(
      column: $table.actaUuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rutaLocal => $composableBuilder(
      column: $table.rutaLocal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hashIntegridad => $composableBuilder(
      column: $table.hashIntegridad,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$EvidenciasFotograficasTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvidenciasFotograficasTable> {
  $$EvidenciasFotograficasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get actaUuid =>
      $composableBuilder(column: $table.actaUuid, builder: (column) => column);

  GeneratedColumn<String> get rutaLocal =>
      $composableBuilder(column: $table.rutaLocal, builder: (column) => column);

  GeneratedColumn<String> get hashIntegridad => $composableBuilder(
      column: $table.hashIntegridad, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EvidenciasFotograficasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EvidenciasFotograficasTable,
    EvidenciasFotografica,
    $$EvidenciasFotograficasTableFilterComposer,
    $$EvidenciasFotograficasTableOrderingComposer,
    $$EvidenciasFotograficasTableAnnotationComposer,
    $$EvidenciasFotograficasTableCreateCompanionBuilder,
    $$EvidenciasFotograficasTableUpdateCompanionBuilder,
    (
      EvidenciasFotografica,
      BaseReferences<_$AppDatabase, $EvidenciasFotograficasTable,
          EvidenciasFotografica>
    ),
    EvidenciasFotografica,
    PrefetchHooks Function()> {
  $$EvidenciasFotograficasTableTableManager(
      _$AppDatabase db, $EvidenciasFotograficasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvidenciasFotograficasTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$EvidenciasFotograficasTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvidenciasFotograficasTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> actaUuid = const Value.absent(),
            Value<String> rutaLocal = const Value.absent(),
            Value<String> hashIntegridad = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EvidenciasFotograficasCompanion(
            id: id,
            actaUuid: actaUuid,
            rutaLocal: rutaLocal,
            hashIntegridad: hashIntegridad,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String actaUuid,
            required String rutaLocal,
            required String hashIntegridad,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EvidenciasFotograficasCompanion.insert(
            id: id,
            actaUuid: actaUuid,
            rutaLocal: rutaLocal,
            hashIntegridad: hashIntegridad,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EvidenciasFotograficasTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $EvidenciasFotograficasTable,
        EvidenciasFotografica,
        $$EvidenciasFotograficasTableFilterComposer,
        $$EvidenciasFotograficasTableOrderingComposer,
        $$EvidenciasFotograficasTableAnnotationComposer,
        $$EvidenciasFotograficasTableCreateCompanionBuilder,
        $$EvidenciasFotograficasTableUpdateCompanionBuilder,
        (
          EvidenciasFotografica,
          BaseReferences<_$AppDatabase, $EvidenciasFotograficasTable,
              EvidenciasFotografica>
        ),
        EvidenciasFotografica,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActasInfraccionTableTableManager get actasInfraccion =>
      $$ActasInfraccionTableTableManager(_db, _db.actasInfraccion);
  $$EvidenciasFotograficasTableTableManager get evidenciasFotograficas =>
      $$EvidenciasFotograficasTableTableManager(
          _db, _db.evidenciasFotograficas);
}

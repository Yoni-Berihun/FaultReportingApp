// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalReportsTable extends LocalReports
    with TableInfo<$LocalReportsTable, LocalReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta =
      const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
      'server_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _trackingIdMeta =
      const VerificationMeta('trackingId');
  @override
  late final GeneratedColumn<String> trackingId = GeneratedColumn<String>(
      'tracking_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactNumberMeta =
      const VerificationMeta('contactNumber');
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
      'contact_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _commonNameMeta =
      const VerificationMeta('commonName');
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
      'common_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoStoragePathMeta =
      const VerificationMeta('photoStoragePath');
  @override
  late final GeneratedColumn<String> photoStoragePath = GeneratedColumn<String>(
      'photo_storage_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _seenAtMeta = const VerificationMeta('seenAt');
  @override
  late final GeneratedColumn<DateTime> seenAt = GeneratedColumn<DateTime>(
      'seen_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _resolvedAtMeta =
      const VerificationMeta('resolvedAt');
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
      'resolved_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _photoDeletedAtMeta =
      const VerificationMeta('photoDeletedAt');
  @override
  late final GeneratedColumn<DateTime> photoDeletedAt =
      GeneratedColumn<DateTime>('photo_deleted_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _localActionStateMeta =
      const VerificationMeta('localActionState');
  @override
  late final GeneratedColumn<String> localActionState = GeneratedColumn<String>(
      'local_action_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  static const VerificationMeta _offlineNotifiedMeta =
      const VerificationMeta('offlineNotified');
  @override
  late final GeneratedColumn<bool> offlineNotified = GeneratedColumn<bool>(
      'offline_notified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("offline_notified" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        serverId,
        trackingId,
        createdAt,
        description,
        contactNumber,
        latitude,
        longitude,
        commonName,
        photoUrl,
        photoStoragePath,
        status,
        seenAt,
        resolvedAt,
        photoDeletedAt,
        lastSyncedAt,
        localActionState,
        offlineNotified
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_reports';
  @override
  VerificationContext validateIntegrity(Insertable<LocalReport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    if (data.containsKey('tracking_id')) {
      context.handle(
          _trackingIdMeta,
          trackingId.isAcceptableOrUnknown(
              data['tracking_id']!, _trackingIdMeta));
    } else if (isInserting) {
      context.missing(_trackingIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('contact_number')) {
      context.handle(
          _contactNumberMeta,
          contactNumber.isAcceptableOrUnknown(
              data['contact_number']!, _contactNumberMeta));
    } else if (isInserting) {
      context.missing(_contactNumberMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('common_name')) {
      context.handle(
          _commonNameMeta,
          commonName.isAcceptableOrUnknown(
              data['common_name']!, _commonNameMeta));
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('photo_storage_path')) {
      context.handle(
          _photoStoragePathMeta,
          photoStoragePath.isAcceptableOrUnknown(
              data['photo_storage_path']!, _photoStoragePathMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('seen_at')) {
      context.handle(_seenAtMeta,
          seenAt.isAcceptableOrUnknown(data['seen_at']!, _seenAtMeta));
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
          _resolvedAtMeta,
          resolvedAt.isAcceptableOrUnknown(
              data['resolved_at']!, _resolvedAtMeta));
    }
    if (data.containsKey('photo_deleted_at')) {
      context.handle(
          _photoDeletedAtMeta,
          photoDeletedAt.isAcceptableOrUnknown(
              data['photo_deleted_at']!, _photoDeletedAtMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('local_action_state')) {
      context.handle(
          _localActionStateMeta,
          localActionState.isAcceptableOrUnknown(
              data['local_action_state']!, _localActionStateMeta));
    }
    if (data.containsKey('offline_notified')) {
      context.handle(
          _offlineNotifiedMeta,
          offlineNotified.isAcceptableOrUnknown(
              data['offline_notified']!, _offlineNotifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalReport(
      serverId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}server_id'])!,
      trackingId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tracking_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      contactNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_number'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      commonName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}common_name'])!,
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      photoStoragePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}photo_storage_path']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      seenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}seen_at']),
      resolvedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}resolved_at']),
      photoDeletedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}photo_deleted_at']),
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      localActionState: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}local_action_state'])!,
      offlineNotified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}offline_notified'])!,
    );
  }

  @override
  $LocalReportsTable createAlias(String alias) {
    return $LocalReportsTable(attachedDatabase, alias);
  }
}

class LocalReport extends DataClass implements Insertable<LocalReport> {
  /// Supabase `reports.id` (int8) — must fit in signed 64-bit.
  final int serverId;
  final String trackingId;
  final DateTime createdAt;
  final String description;
  final String contactNumber;
  final double latitude;
  final double longitude;
  final String commonName;
  final String? photoUrl;
  final String? photoStoragePath;
  final String status;
  final DateTime? seenAt;
  final DateTime? resolvedAt;
  final DateTime? photoDeletedAt;
  final DateTime? lastSyncedAt;

  /// synced | pending_seen | failed_seen
  final String localActionState;
  final bool offlineNotified;
  const LocalReport(
      {required this.serverId,
      required this.trackingId,
      required this.createdAt,
      required this.description,
      required this.contactNumber,
      required this.latitude,
      required this.longitude,
      required this.commonName,
      this.photoUrl,
      this.photoStoragePath,
      required this.status,
      this.seenAt,
      this.resolvedAt,
      this.photoDeletedAt,
      this.lastSyncedAt,
      required this.localActionState,
      required this.offlineNotified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['tracking_id'] = Variable<String>(trackingId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['description'] = Variable<String>(description);
    map['contact_number'] = Variable<String>(contactNumber);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['common_name'] = Variable<String>(commonName);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || photoStoragePath != null) {
      map['photo_storage_path'] = Variable<String>(photoStoragePath);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || seenAt != null) {
      map['seen_at'] = Variable<DateTime>(seenAt);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || photoDeletedAt != null) {
      map['photo_deleted_at'] = Variable<DateTime>(photoDeletedAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['local_action_state'] = Variable<String>(localActionState);
    map['offline_notified'] = Variable<bool>(offlineNotified);
    return map;
  }

  LocalReportsCompanion toCompanion(bool nullToAbsent) {
    return LocalReportsCompanion(
      serverId: Value(serverId),
      trackingId: Value(trackingId),
      createdAt: Value(createdAt),
      description: Value(description),
      contactNumber: Value(contactNumber),
      latitude: Value(latitude),
      longitude: Value(longitude),
      commonName: Value(commonName),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      photoStoragePath: photoStoragePath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoStoragePath),
      status: Value(status),
      seenAt:
          seenAt == null && nullToAbsent ? const Value.absent() : Value(seenAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      photoDeletedAt: photoDeletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(photoDeletedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      localActionState: Value(localActionState),
      offlineNotified: Value(offlineNotified),
    );
  }

  factory LocalReport.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalReport(
      serverId: serializer.fromJson<int>(json['serverId']),
      trackingId: serializer.fromJson<String>(json['trackingId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      description: serializer.fromJson<String>(json['description']),
      contactNumber: serializer.fromJson<String>(json['contactNumber']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      commonName: serializer.fromJson<String>(json['commonName']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      photoStoragePath: serializer.fromJson<String?>(json['photoStoragePath']),
      status: serializer.fromJson<String>(json['status']),
      seenAt: serializer.fromJson<DateTime?>(json['seenAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      photoDeletedAt: serializer.fromJson<DateTime?>(json['photoDeletedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      localActionState: serializer.fromJson<String>(json['localActionState']),
      offlineNotified: serializer.fromJson<bool>(json['offlineNotified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'trackingId': serializer.toJson<String>(trackingId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'description': serializer.toJson<String>(description),
      'contactNumber': serializer.toJson<String>(contactNumber),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'commonName': serializer.toJson<String>(commonName),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'photoStoragePath': serializer.toJson<String?>(photoStoragePath),
      'status': serializer.toJson<String>(status),
      'seenAt': serializer.toJson<DateTime?>(seenAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'photoDeletedAt': serializer.toJson<DateTime?>(photoDeletedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'localActionState': serializer.toJson<String>(localActionState),
      'offlineNotified': serializer.toJson<bool>(offlineNotified),
    };
  }

  LocalReport copyWith(
          {int? serverId,
          String? trackingId,
          DateTime? createdAt,
          String? description,
          String? contactNumber,
          double? latitude,
          double? longitude,
          String? commonName,
          Value<String?> photoUrl = const Value.absent(),
          Value<String?> photoStoragePath = const Value.absent(),
          String? status,
          Value<DateTime?> seenAt = const Value.absent(),
          Value<DateTime?> resolvedAt = const Value.absent(),
          Value<DateTime?> photoDeletedAt = const Value.absent(),
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          String? localActionState,
          bool? offlineNotified}) =>
      LocalReport(
        serverId: serverId ?? this.serverId,
        trackingId: trackingId ?? this.trackingId,
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
        contactNumber: contactNumber ?? this.contactNumber,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        commonName: commonName ?? this.commonName,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        photoStoragePath: photoStoragePath.present
            ? photoStoragePath.value
            : this.photoStoragePath,
        status: status ?? this.status,
        seenAt: seenAt.present ? seenAt.value : this.seenAt,
        resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
        photoDeletedAt:
            photoDeletedAt.present ? photoDeletedAt.value : this.photoDeletedAt,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        localActionState: localActionState ?? this.localActionState,
        offlineNotified: offlineNotified ?? this.offlineNotified,
      );
  LocalReport copyWithCompanion(LocalReportsCompanion data) {
    return LocalReport(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      trackingId:
          data.trackingId.present ? data.trackingId.value : this.trackingId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      description:
          data.description.present ? data.description.value : this.description,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      commonName:
          data.commonName.present ? data.commonName.value : this.commonName,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      photoStoragePath: data.photoStoragePath.present
          ? data.photoStoragePath.value
          : this.photoStoragePath,
      status: data.status.present ? data.status.value : this.status,
      seenAt: data.seenAt.present ? data.seenAt.value : this.seenAt,
      resolvedAt:
          data.resolvedAt.present ? data.resolvedAt.value : this.resolvedAt,
      photoDeletedAt: data.photoDeletedAt.present
          ? data.photoDeletedAt.value
          : this.photoDeletedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      localActionState: data.localActionState.present
          ? data.localActionState.value
          : this.localActionState,
      offlineNotified: data.offlineNotified.present
          ? data.offlineNotified.value
          : this.offlineNotified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalReport(')
          ..write('serverId: $serverId, ')
          ..write('trackingId: $trackingId, ')
          ..write('createdAt: $createdAt, ')
          ..write('description: $description, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('commonName: $commonName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('photoStoragePath: $photoStoragePath, ')
          ..write('status: $status, ')
          ..write('seenAt: $seenAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('photoDeletedAt: $photoDeletedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('localActionState: $localActionState, ')
          ..write('offlineNotified: $offlineNotified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      serverId,
      trackingId,
      createdAt,
      description,
      contactNumber,
      latitude,
      longitude,
      commonName,
      photoUrl,
      photoStoragePath,
      status,
      seenAt,
      resolvedAt,
      photoDeletedAt,
      lastSyncedAt,
      localActionState,
      offlineNotified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalReport &&
          other.serverId == this.serverId &&
          other.trackingId == this.trackingId &&
          other.createdAt == this.createdAt &&
          other.description == this.description &&
          other.contactNumber == this.contactNumber &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.commonName == this.commonName &&
          other.photoUrl == this.photoUrl &&
          other.photoStoragePath == this.photoStoragePath &&
          other.status == this.status &&
          other.seenAt == this.seenAt &&
          other.resolvedAt == this.resolvedAt &&
          other.photoDeletedAt == this.photoDeletedAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.localActionState == this.localActionState &&
          other.offlineNotified == this.offlineNotified);
}

class LocalReportsCompanion extends UpdateCompanion<LocalReport> {
  final Value<int> serverId;
  final Value<String> trackingId;
  final Value<DateTime> createdAt;
  final Value<String> description;
  final Value<String> contactNumber;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> commonName;
  final Value<String?> photoUrl;
  final Value<String?> photoStoragePath;
  final Value<String> status;
  final Value<DateTime?> seenAt;
  final Value<DateTime?> resolvedAt;
  final Value<DateTime?> photoDeletedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<String> localActionState;
  final Value<bool> offlineNotified;
  const LocalReportsCompanion({
    this.serverId = const Value.absent(),
    this.trackingId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.description = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.commonName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.photoStoragePath = const Value.absent(),
    this.status = const Value.absent(),
    this.seenAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.photoDeletedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.localActionState = const Value.absent(),
    this.offlineNotified = const Value.absent(),
  });
  LocalReportsCompanion.insert({
    this.serverId = const Value.absent(),
    required String trackingId,
    required DateTime createdAt,
    required String description,
    required String contactNumber,
    required double latitude,
    required double longitude,
    this.commonName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.photoStoragePath = const Value.absent(),
    required String status,
    this.seenAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.photoDeletedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.localActionState = const Value.absent(),
    this.offlineNotified = const Value.absent(),
  })  : trackingId = Value(trackingId),
        createdAt = Value(createdAt),
        description = Value(description),
        contactNumber = Value(contactNumber),
        latitude = Value(latitude),
        longitude = Value(longitude),
        status = Value(status);
  static Insertable<LocalReport> custom({
    Expression<int>? serverId,
    Expression<String>? trackingId,
    Expression<DateTime>? createdAt,
    Expression<String>? description,
    Expression<String>? contactNumber,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? commonName,
    Expression<String>? photoUrl,
    Expression<String>? photoStoragePath,
    Expression<String>? status,
    Expression<DateTime>? seenAt,
    Expression<DateTime>? resolvedAt,
    Expression<DateTime>? photoDeletedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? localActionState,
    Expression<bool>? offlineNotified,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (trackingId != null) 'tracking_id': trackingId,
      if (createdAt != null) 'created_at': createdAt,
      if (description != null) 'description': description,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (commonName != null) 'common_name': commonName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (photoStoragePath != null) 'photo_storage_path': photoStoragePath,
      if (status != null) 'status': status,
      if (seenAt != null) 'seen_at': seenAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (photoDeletedAt != null) 'photo_deleted_at': photoDeletedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (localActionState != null) 'local_action_state': localActionState,
      if (offlineNotified != null) 'offline_notified': offlineNotified,
    });
  }

  LocalReportsCompanion copyWith(
      {Value<int>? serverId,
      Value<String>? trackingId,
      Value<DateTime>? createdAt,
      Value<String>? description,
      Value<String>? contactNumber,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String>? commonName,
      Value<String?>? photoUrl,
      Value<String?>? photoStoragePath,
      Value<String>? status,
      Value<DateTime?>? seenAt,
      Value<DateTime?>? resolvedAt,
      Value<DateTime?>? photoDeletedAt,
      Value<DateTime?>? lastSyncedAt,
      Value<String>? localActionState,
      Value<bool>? offlineNotified}) {
    return LocalReportsCompanion(
      serverId: serverId ?? this.serverId,
      trackingId: trackingId ?? this.trackingId,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      contactNumber: contactNumber ?? this.contactNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      commonName: commonName ?? this.commonName,
      photoUrl: photoUrl ?? this.photoUrl,
      photoStoragePath: photoStoragePath ?? this.photoStoragePath,
      status: status ?? this.status,
      seenAt: seenAt ?? this.seenAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      photoDeletedAt: photoDeletedAt ?? this.photoDeletedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      localActionState: localActionState ?? this.localActionState,
      offlineNotified: offlineNotified ?? this.offlineNotified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (trackingId.present) {
      map['tracking_id'] = Variable<String>(trackingId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (photoStoragePath.present) {
      map['photo_storage_path'] = Variable<String>(photoStoragePath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (seenAt.present) {
      map['seen_at'] = Variable<DateTime>(seenAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (photoDeletedAt.present) {
      map['photo_deleted_at'] = Variable<DateTime>(photoDeletedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (localActionState.present) {
      map['local_action_state'] = Variable<String>(localActionState.value);
    }
    if (offlineNotified.present) {
      map['offline_notified'] = Variable<bool>(offlineNotified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalReportsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('trackingId: $trackingId, ')
          ..write('createdAt: $createdAt, ')
          ..write('description: $description, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('commonName: $commonName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('photoStoragePath: $photoStoragePath, ')
          ..write('status: $status, ')
          ..write('seenAt: $seenAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('photoDeletedAt: $photoDeletedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('localActionState: $localActionState, ')
          ..write('offlineNotified: $offlineNotified')
          ..write(')'))
        .toString();
  }
}

class $SyncKvTable extends SyncKv with TableInfo<$SyncKvTable, SyncKvData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncKvTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_kv';
  @override
  VerificationContext validateIntegrity(Insertable<SyncKvData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncKvData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncKvData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
    );
  }

  @override
  $SyncKvTable createAlias(String alias) {
    return $SyncKvTable(attachedDatabase, alias);
  }
}

class SyncKvData extends DataClass implements Insertable<SyncKvData> {
  final String key;
  final String? value;
  const SyncKvData({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  SyncKvCompanion toCompanion(bool nullToAbsent) {
    return SyncKvCompanion(
      key: Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory SyncKvData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncKvData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  SyncKvData copyWith(
          {String? key, Value<String?> value = const Value.absent()}) =>
      SyncKvData(
        key: key ?? this.key,
        value: value.present ? value.value : this.value,
      );
  SyncKvData copyWithCompanion(SyncKvCompanion data) {
    return SyncKvData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncKvData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncKvData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncKvCompanion extends UpdateCompanion<SyncKvData> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const SyncKvCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncKvCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SyncKvData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncKvCompanion copyWith(
      {Value<String>? key, Value<String?>? value, Value<int>? rowid}) {
    return SyncKvCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncKvCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalReportsTable localReports = $LocalReportsTable(this);
  late final $SyncKvTable syncKv = $SyncKvTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localReports, syncKv];
}

typedef $$LocalReportsTableCreateCompanionBuilder = LocalReportsCompanion
    Function({
  Value<int> serverId,
  required String trackingId,
  required DateTime createdAt,
  required String description,
  required String contactNumber,
  required double latitude,
  required double longitude,
  Value<String> commonName,
  Value<String?> photoUrl,
  Value<String?> photoStoragePath,
  required String status,
  Value<DateTime?> seenAt,
  Value<DateTime?> resolvedAt,
  Value<DateTime?> photoDeletedAt,
  Value<DateTime?> lastSyncedAt,
  Value<String> localActionState,
  Value<bool> offlineNotified,
});
typedef $$LocalReportsTableUpdateCompanionBuilder = LocalReportsCompanion
    Function({
  Value<int> serverId,
  Value<String> trackingId,
  Value<DateTime> createdAt,
  Value<String> description,
  Value<String> contactNumber,
  Value<double> latitude,
  Value<double> longitude,
  Value<String> commonName,
  Value<String?> photoUrl,
  Value<String?> photoStoragePath,
  Value<String> status,
  Value<DateTime?> seenAt,
  Value<DateTime?> resolvedAt,
  Value<DateTime?> photoDeletedAt,
  Value<DateTime?> lastSyncedAt,
  Value<String> localActionState,
  Value<bool> offlineNotified,
});

class $$LocalReportsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalReportsTable> {
  $$LocalReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackingId => $composableBuilder(
      column: $table.trackingId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contactNumber => $composableBuilder(
      column: $table.contactNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commonName => $composableBuilder(
      column: $table.commonName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoStoragePath => $composableBuilder(
      column: $table.photoStoragePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get seenAt => $composableBuilder(
      column: $table.seenAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get photoDeletedAt => $composableBuilder(
      column: $table.photoDeletedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localActionState => $composableBuilder(
      column: $table.localActionState,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get offlineNotified => $composableBuilder(
      column: $table.offlineNotified,
      builder: (column) => ColumnFilters(column));
}

class $$LocalReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalReportsTable> {
  $$LocalReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackingId => $composableBuilder(
      column: $table.trackingId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactNumber => $composableBuilder(
      column: $table.contactNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commonName => $composableBuilder(
      column: $table.commonName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoStoragePath => $composableBuilder(
      column: $table.photoStoragePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get seenAt => $composableBuilder(
      column: $table.seenAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get photoDeletedAt => $composableBuilder(
      column: $table.photoDeletedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localActionState => $composableBuilder(
      column: $table.localActionState,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get offlineNotified => $composableBuilder(
      column: $table.offlineNotified,
      builder: (column) => ColumnOrderings(column));
}

class $$LocalReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalReportsTable> {
  $$LocalReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get trackingId => $composableBuilder(
      column: $table.trackingId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get contactNumber => $composableBuilder(
      column: $table.contactNumber, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get commonName => $composableBuilder(
      column: $table.commonName, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get photoStoragePath => $composableBuilder(
      column: $table.photoStoragePath, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get seenAt =>
      $composableBuilder(column: $table.seenAt, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get photoDeletedAt => $composableBuilder(
      column: $table.photoDeletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<String> get localActionState => $composableBuilder(
      column: $table.localActionState, builder: (column) => column);

  GeneratedColumn<bool> get offlineNotified => $composableBuilder(
      column: $table.offlineNotified, builder: (column) => column);
}

class $$LocalReportsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalReportsTable,
    LocalReport,
    $$LocalReportsTableFilterComposer,
    $$LocalReportsTableOrderingComposer,
    $$LocalReportsTableAnnotationComposer,
    $$LocalReportsTableCreateCompanionBuilder,
    $$LocalReportsTableUpdateCompanionBuilder,
    (
      LocalReport,
      BaseReferences<_$AppDatabase, $LocalReportsTable, LocalReport>
    ),
    LocalReport,
    PrefetchHooks Function()> {
  $$LocalReportsTableTableManager(_$AppDatabase db, $LocalReportsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> serverId = const Value.absent(),
            Value<String> trackingId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> contactNumber = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String> commonName = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<String?> photoStoragePath = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> seenAt = const Value.absent(),
            Value<DateTime?> resolvedAt = const Value.absent(),
            Value<DateTime?> photoDeletedAt = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<String> localActionState = const Value.absent(),
            Value<bool> offlineNotified = const Value.absent(),
          }) =>
              LocalReportsCompanion(
            serverId: serverId,
            trackingId: trackingId,
            createdAt: createdAt,
            description: description,
            contactNumber: contactNumber,
            latitude: latitude,
            longitude: longitude,
            commonName: commonName,
            photoUrl: photoUrl,
            photoStoragePath: photoStoragePath,
            status: status,
            seenAt: seenAt,
            resolvedAt: resolvedAt,
            photoDeletedAt: photoDeletedAt,
            lastSyncedAt: lastSyncedAt,
            localActionState: localActionState,
            offlineNotified: offlineNotified,
          ),
          createCompanionCallback: ({
            Value<int> serverId = const Value.absent(),
            required String trackingId,
            required DateTime createdAt,
            required String description,
            required String contactNumber,
            required double latitude,
            required double longitude,
            Value<String> commonName = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<String?> photoStoragePath = const Value.absent(),
            required String status,
            Value<DateTime?> seenAt = const Value.absent(),
            Value<DateTime?> resolvedAt = const Value.absent(),
            Value<DateTime?> photoDeletedAt = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<String> localActionState = const Value.absent(),
            Value<bool> offlineNotified = const Value.absent(),
          }) =>
              LocalReportsCompanion.insert(
            serverId: serverId,
            trackingId: trackingId,
            createdAt: createdAt,
            description: description,
            contactNumber: contactNumber,
            latitude: latitude,
            longitude: longitude,
            commonName: commonName,
            photoUrl: photoUrl,
            photoStoragePath: photoStoragePath,
            status: status,
            seenAt: seenAt,
            resolvedAt: resolvedAt,
            photoDeletedAt: photoDeletedAt,
            lastSyncedAt: lastSyncedAt,
            localActionState: localActionState,
            offlineNotified: offlineNotified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalReportsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalReportsTable,
    LocalReport,
    $$LocalReportsTableFilterComposer,
    $$LocalReportsTableOrderingComposer,
    $$LocalReportsTableAnnotationComposer,
    $$LocalReportsTableCreateCompanionBuilder,
    $$LocalReportsTableUpdateCompanionBuilder,
    (
      LocalReport,
      BaseReferences<_$AppDatabase, $LocalReportsTable, LocalReport>
    ),
    LocalReport,
    PrefetchHooks Function()>;
typedef $$SyncKvTableCreateCompanionBuilder = SyncKvCompanion Function({
  required String key,
  Value<String?> value,
  Value<int> rowid,
});
typedef $$SyncKvTableUpdateCompanionBuilder = SyncKvCompanion Function({
  Value<String> key,
  Value<String?> value,
  Value<int> rowid,
});

class $$SyncKvTableFilterComposer
    extends Composer<_$AppDatabase, $SyncKvTable> {
  $$SyncKvTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SyncKvTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncKvTable> {
  $$SyncKvTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SyncKvTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncKvTable> {
  $$SyncKvTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncKvTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncKvTable,
    SyncKvData,
    $$SyncKvTableFilterComposer,
    $$SyncKvTableOrderingComposer,
    $$SyncKvTableAnnotationComposer,
    $$SyncKvTableCreateCompanionBuilder,
    $$SyncKvTableUpdateCompanionBuilder,
    (SyncKvData, BaseReferences<_$AppDatabase, $SyncKvTable, SyncKvData>),
    SyncKvData,
    PrefetchHooks Function()> {
  $$SyncKvTableTableManager(_$AppDatabase db, $SyncKvTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncKvTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncKvTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncKvTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String?> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncKvCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            Value<String?> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncKvCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncKvTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncKvTable,
    SyncKvData,
    $$SyncKvTableFilterComposer,
    $$SyncKvTableOrderingComposer,
    $$SyncKvTableAnnotationComposer,
    $$SyncKvTableCreateCompanionBuilder,
    $$SyncKvTableUpdateCompanionBuilder,
    (SyncKvData, BaseReferences<_$AppDatabase, $SyncKvTable, SyncKvData>),
    SyncKvData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalReportsTableTableManager get localReports =>
      $$LocalReportsTableTableManager(_db, _db.localReports);
  $$SyncKvTableTableManager get syncKv =>
      $$SyncKvTableTableManager(_db, _db.syncKv);
}

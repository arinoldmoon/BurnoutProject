///
//  Generated code. Do not modify.
//  source: oven.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $3;
import 'google/protobuf/duration.pb.dart' as $4;

import 'oven.pbenum.dart';

export 'oven.pbenum.dart';

class ProtoOvenInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SerialNumber', $pb.PbFieldType.O3, protoName: 'SerialNumber')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MachineModel', $pb.PbFieldType.O3, protoName: 'MachineModel')
    ..aOM<$3.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'WarrantyStart', protoName: 'WarrantyStart', subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'WarrantyEnd', protoName: 'WarrantyEnd', subBuilder: $3.Timestamp.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MachineName', protoName: 'MachineName')
    ..hasRequiredFields = false
  ;

  ProtoOvenInfo._() : super();
  factory ProtoOvenInfo({
    $core.int? serialNumber,
    $core.int? machineModel,
    $3.Timestamp? warrantyStart,
    $3.Timestamp? warrantyEnd,
    $core.String? machineName,
  }) {
    final _result = create();
    if (serialNumber != null) {
      _result.serialNumber = serialNumber;
    }
    if (machineModel != null) {
      _result.machineModel = machineModel;
    }
    if (warrantyStart != null) {
      _result.warrantyStart = warrantyStart;
    }
    if (warrantyEnd != null) {
      _result.warrantyEnd = warrantyEnd;
    }
    if (machineName != null) {
      _result.machineName = machineName;
    }
    return _result;
  }
  factory ProtoOvenInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoOvenInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoOvenInfo clone() => ProtoOvenInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoOvenInfo copyWith(void Function(ProtoOvenInfo) updates) => super.copyWith((message) => updates(message as ProtoOvenInfo)) as ProtoOvenInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoOvenInfo create() => ProtoOvenInfo._();
  ProtoOvenInfo createEmptyInstance() => create();
  static $pb.PbList<ProtoOvenInfo> createRepeated() => $pb.PbList<ProtoOvenInfo>();
  @$core.pragma('dart2js:noInline')
  static ProtoOvenInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoOvenInfo>(create);
  static ProtoOvenInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get serialNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set serialNumber($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSerialNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerialNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get machineModel => $_getIZ(1);
  @$pb.TagNumber(2)
  set machineModel($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMachineModel() => $_has(1);
  @$pb.TagNumber(2)
  void clearMachineModel() => clearField(2);

  @$pb.TagNumber(3)
  $3.Timestamp get warrantyStart => $_getN(2);
  @$pb.TagNumber(3)
  set warrantyStart($3.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWarrantyStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearWarrantyStart() => clearField(3);
  @$pb.TagNumber(3)
  $3.Timestamp ensureWarrantyStart() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Timestamp get warrantyEnd => $_getN(3);
  @$pb.TagNumber(4)
  set warrantyEnd($3.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasWarrantyEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearWarrantyEnd() => clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureWarrantyEnd() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get machineName => $_getSZ(4);
  @$pb.TagNumber(5)
  set machineName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMachineName() => $_has(4);
  @$pb.TagNumber(5)
  void clearMachineName() => clearField(5);
}

class ProtoOvenSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SettingId', $pb.PbFieldType.O3, protoName: 'SettingId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AfbStartTemp', $pb.PbFieldType.O3, protoName: 'AfbStartTemp')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AfbEndTemp', $pb.PbFieldType.O3, protoName: 'AfbEndTemp')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AfbDelay', $pb.PbFieldType.O3, protoName: 'AfbDelay')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TubeStartTemp', $pb.PbFieldType.O3, protoName: 'TubeStartTemp')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FloorStartTemp', $pb.PbFieldType.O3, protoName: 'FloorStartTemp')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AlarmOven', $pb.PbFieldType.O3, protoName: 'AlarmOven')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AlarmAfb', $pb.PbFieldType.O3, protoName: 'AlarmAfb')
    ..hasRequiredFields = false
  ;

  ProtoOvenSetting._() : super();
  factory ProtoOvenSetting({
    $core.int? settingId,
    $core.int? afbStartTemp,
    $core.int? afbEndTemp,
    $core.int? afbDelay,
    $core.int? tubeStartTemp,
    $core.int? floorStartTemp,
    $core.int? alarmOven,
    $core.int? alarmAfb,
  }) {
    final _result = create();
    if (settingId != null) {
      _result.settingId = settingId;
    }
    if (afbStartTemp != null) {
      _result.afbStartTemp = afbStartTemp;
    }
    if (afbEndTemp != null) {
      _result.afbEndTemp = afbEndTemp;
    }
    if (afbDelay != null) {
      _result.afbDelay = afbDelay;
    }
    if (tubeStartTemp != null) {
      _result.tubeStartTemp = tubeStartTemp;
    }
    if (floorStartTemp != null) {
      _result.floorStartTemp = floorStartTemp;
    }
    if (alarmOven != null) {
      _result.alarmOven = alarmOven;
    }
    if (alarmAfb != null) {
      _result.alarmAfb = alarmAfb;
    }
    return _result;
  }
  factory ProtoOvenSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoOvenSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoOvenSetting clone() => ProtoOvenSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoOvenSetting copyWith(void Function(ProtoOvenSetting) updates) => super.copyWith((message) => updates(message as ProtoOvenSetting)) as ProtoOvenSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoOvenSetting create() => ProtoOvenSetting._();
  ProtoOvenSetting createEmptyInstance() => create();
  static $pb.PbList<ProtoOvenSetting> createRepeated() => $pb.PbList<ProtoOvenSetting>();
  @$core.pragma('dart2js:noInline')
  static ProtoOvenSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoOvenSetting>(create);
  static ProtoOvenSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get settingId => $_getIZ(0);
  @$pb.TagNumber(1)
  set settingId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSettingId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettingId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get afbStartTemp => $_getIZ(1);
  @$pb.TagNumber(2)
  set afbStartTemp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAfbStartTemp() => $_has(1);
  @$pb.TagNumber(2)
  void clearAfbStartTemp() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get afbEndTemp => $_getIZ(2);
  @$pb.TagNumber(3)
  set afbEndTemp($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAfbEndTemp() => $_has(2);
  @$pb.TagNumber(3)
  void clearAfbEndTemp() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get afbDelay => $_getIZ(3);
  @$pb.TagNumber(4)
  set afbDelay($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAfbDelay() => $_has(3);
  @$pb.TagNumber(4)
  void clearAfbDelay() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get tubeStartTemp => $_getIZ(4);
  @$pb.TagNumber(5)
  set tubeStartTemp($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTubeStartTemp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTubeStartTemp() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get floorStartTemp => $_getIZ(5);
  @$pb.TagNumber(6)
  set floorStartTemp($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFloorStartTemp() => $_has(5);
  @$pb.TagNumber(6)
  void clearFloorStartTemp() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get alarmOven => $_getIZ(6);
  @$pb.TagNumber(7)
  set alarmOven($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAlarmOven() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlarmOven() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get alarmAfb => $_getIZ(7);
  @$pb.TagNumber(8)
  set alarmAfb($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAlarmAfb() => $_has(7);
  @$pb.TagNumber(8)
  void clearAlarmAfb() => clearField(8);
}

class ProtoOvenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOM<Temp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Temp', protoName: 'Temp', subBuilder: Temp.create)
    ..aOM<Coil>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Coil', protoName: 'Coil', subBuilder: Coil.create)
    ..aOM<mcStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Status', protoName: 'Status', subBuilder: mcStatus.create)
    ..hasRequiredFields = false
  ;

  ProtoOvenResponse._() : super();
  factory ProtoOvenResponse({
    Temp? temp,
    Coil? coil,
    mcStatus? status,
  }) {
    final _result = create();
    if (temp != null) {
      _result.temp = temp;
    }
    if (coil != null) {
      _result.coil = coil;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ProtoOvenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoOvenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoOvenResponse clone() => ProtoOvenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoOvenResponse copyWith(void Function(ProtoOvenResponse) updates) => super.copyWith((message) => updates(message as ProtoOvenResponse)) as ProtoOvenResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoOvenResponse create() => ProtoOvenResponse._();
  ProtoOvenResponse createEmptyInstance() => create();
  static $pb.PbList<ProtoOvenResponse> createRepeated() => $pb.PbList<ProtoOvenResponse>();
  @$core.pragma('dart2js:noInline')
  static ProtoOvenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoOvenResponse>(create);
  static ProtoOvenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Temp get temp => $_getN(0);
  @$pb.TagNumber(1)
  set temp(Temp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTemp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTemp() => clearField(1);
  @$pb.TagNumber(1)
  Temp ensureTemp() => $_ensure(0);

  @$pb.TagNumber(2)
  Coil get coil => $_getN(1);
  @$pb.TagNumber(2)
  set coil(Coil v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCoil() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoil() => clearField(2);
  @$pb.TagNumber(2)
  Coil ensureCoil() => $_ensure(1);

  @$pb.TagNumber(3)
  mcStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(mcStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
  @$pb.TagNumber(3)
  mcStatus ensureStatus() => $_ensure(2);
}

class Temp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Temp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempOven', $pb.PbFieldType.O3, protoName: 'TempOven')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempAFB', $pb.PbFieldType.O3, protoName: 'TempAFB')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempTube', $pb.PbFieldType.O3, protoName: 'TempTube')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempFloor', $pb.PbFieldType.O3, protoName: 'TempFloor')
    ..hasRequiredFields = false
  ;

  Temp._() : super();
  factory Temp({
    $core.int? tempOven,
    $core.int? tempAFB,
    $core.int? tempTube,
    $core.int? tempFloor,
  }) {
    final _result = create();
    if (tempOven != null) {
      _result.tempOven = tempOven;
    }
    if (tempAFB != null) {
      _result.tempAFB = tempAFB;
    }
    if (tempTube != null) {
      _result.tempTube = tempTube;
    }
    if (tempFloor != null) {
      _result.tempFloor = tempFloor;
    }
    return _result;
  }
  factory Temp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Temp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Temp clone() => Temp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Temp copyWith(void Function(Temp) updates) => super.copyWith((message) => updates(message as Temp)) as Temp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Temp create() => Temp._();
  Temp createEmptyInstance() => create();
  static $pb.PbList<Temp> createRepeated() => $pb.PbList<Temp>();
  @$core.pragma('dart2js:noInline')
  static Temp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Temp>(create);
  static Temp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tempOven => $_getIZ(0);
  @$pb.TagNumber(1)
  set tempOven($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTempOven() => $_has(0);
  @$pb.TagNumber(1)
  void clearTempOven() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get tempAFB => $_getIZ(1);
  @$pb.TagNumber(2)
  set tempAFB($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTempAFB() => $_has(1);
  @$pb.TagNumber(2)
  void clearTempAFB() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get tempTube => $_getIZ(2);
  @$pb.TagNumber(3)
  set tempTube($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTempTube() => $_has(2);
  @$pb.TagNumber(3)
  void clearTempTube() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get tempFloor => $_getIZ(3);
  @$pb.TagNumber(4)
  set tempFloor($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTempFloor() => $_has(3);
  @$pb.TagNumber(4)
  void clearTempFloor() => clearField(4);
}

class Coil extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Coil', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CoilOven', protoName: 'CoilOven')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CoilAFB', protoName: 'CoilAFB')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CoilTube', protoName: 'CoilTube')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CoilPump', protoName: 'CoilPump')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CoilFloor', protoName: 'CoilFloor')
    ..hasRequiredFields = false
  ;

  Coil._() : super();
  factory Coil({
    $core.bool? coilOven,
    $core.bool? coilAFB,
    $core.bool? coilTube,
    $core.bool? coilPump,
    $core.bool? coilFloor,
  }) {
    final _result = create();
    if (coilOven != null) {
      _result.coilOven = coilOven;
    }
    if (coilAFB != null) {
      _result.coilAFB = coilAFB;
    }
    if (coilTube != null) {
      _result.coilTube = coilTube;
    }
    if (coilPump != null) {
      _result.coilPump = coilPump;
    }
    if (coilFloor != null) {
      _result.coilFloor = coilFloor;
    }
    return _result;
  }
  factory Coil.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Coil.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Coil clone() => Coil()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Coil copyWith(void Function(Coil) updates) => super.copyWith((message) => updates(message as Coil)) as Coil; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Coil create() => Coil._();
  Coil createEmptyInstance() => create();
  static $pb.PbList<Coil> createRepeated() => $pb.PbList<Coil>();
  @$core.pragma('dart2js:noInline')
  static Coil getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Coil>(create);
  static Coil? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get coilOven => $_getBF(0);
  @$pb.TagNumber(1)
  set coilOven($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCoilOven() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoilOven() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get coilAFB => $_getBF(1);
  @$pb.TagNumber(2)
  set coilAFB($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCoilAFB() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoilAFB() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get coilTube => $_getBF(2);
  @$pb.TagNumber(3)
  set coilTube($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCoilTube() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoilTube() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get coilPump => $_getBF(3);
  @$pb.TagNumber(4)
  set coilPump($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCoilPump() => $_has(3);
  @$pb.TagNumber(4)
  void clearCoilPump() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get coilFloor => $_getBF(4);
  @$pb.TagNumber(5)
  set coilFloor($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCoilFloor() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoilFloor() => clearField(5);
}

class mcStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mcStatus', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Door', protoName: 'Door')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Operation', protoName: 'Operation')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternId', $pb.PbFieldType.O3, protoName: 'PatternId')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TotalStep', $pb.PbFieldType.O3, protoName: 'TotalStep')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CurrentStep', $pb.PbFieldType.O3, protoName: 'CurrentStep')
    ..e<PatternStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternStatus', $pb.PbFieldType.OE, protoName: 'PatternStatus', defaultOrMaker: PatternStatus.Standby, valueOf: PatternStatus.valueOf, enumValues: PatternStatus.values)
    ..aOM<$4.Duration>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RemainHours', protoName: 'RemainHours', subBuilder: $4.Duration.create)
    ..aOM<$4.Duration>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RemainMins', protoName: 'RemainMins', subBuilder: $4.Duration.create)
    ..hasRequiredFields = false
  ;

  mcStatus._() : super();
  factory mcStatus({
    $core.bool? door,
    $core.bool? operation,
    $core.int? patternId,
    $core.int? totalStep,
    $core.int? currentStep,
    PatternStatus? patternStatus,
    $4.Duration? remainHours,
    $4.Duration? remainMins,
  }) {
    final _result = create();
    if (door != null) {
      _result.door = door;
    }
    if (operation != null) {
      _result.operation = operation;
    }
    if (patternId != null) {
      _result.patternId = patternId;
    }
    if (totalStep != null) {
      _result.totalStep = totalStep;
    }
    if (currentStep != null) {
      _result.currentStep = currentStep;
    }
    if (patternStatus != null) {
      _result.patternStatus = patternStatus;
    }
    if (remainHours != null) {
      _result.remainHours = remainHours;
    }
    if (remainMins != null) {
      _result.remainMins = remainMins;
    }
    return _result;
  }
  factory mcStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory mcStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  mcStatus clone() => mcStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  mcStatus copyWith(void Function(mcStatus) updates) => super.copyWith((message) => updates(message as mcStatus)) as mcStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static mcStatus create() => mcStatus._();
  mcStatus createEmptyInstance() => create();
  static $pb.PbList<mcStatus> createRepeated() => $pb.PbList<mcStatus>();
  @$core.pragma('dart2js:noInline')
  static mcStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<mcStatus>(create);
  static mcStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get door => $_getBF(0);
  @$pb.TagNumber(1)
  set door($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDoor() => $_has(0);
  @$pb.TagNumber(1)
  void clearDoor() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get operation => $_getBF(1);
  @$pb.TagNumber(2)
  set operation($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get patternId => $_getIZ(2);
  @$pb.TagNumber(3)
  set patternId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPatternId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPatternId() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalStep => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalStep($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalStep() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get currentStep => $_getIZ(4);
  @$pb.TagNumber(5)
  set currentStep($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentStep() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentStep() => clearField(5);

  @$pb.TagNumber(6)
  PatternStatus get patternStatus => $_getN(5);
  @$pb.TagNumber(6)
  set patternStatus(PatternStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPatternStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearPatternStatus() => clearField(6);

  @$pb.TagNumber(7)
  $4.Duration get remainHours => $_getN(6);
  @$pb.TagNumber(7)
  set remainHours($4.Duration v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRemainHours() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemainHours() => clearField(7);
  @$pb.TagNumber(7)
  $4.Duration ensureRemainHours() => $_ensure(6);

  @$pb.TagNumber(8)
  $4.Duration get remainMins => $_getN(7);
  @$pb.TagNumber(8)
  set remainMins($4.Duration v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasRemainMins() => $_has(7);
  @$pb.TagNumber(8)
  void clearRemainMins() => clearField(8);
  @$pb.TagNumber(8)
  $4.Duration ensureRemainMins() => $_ensure(7);
}

class ProtoPattern extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPattern', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternId', $pb.PbFieldType.O3, protoName: 'PatternId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternName', protoName: 'PatternName')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StepCount', $pb.PbFieldType.O3, protoName: 'StepCount')
    ..aOM<$4.Duration>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TotalTime', protoName: 'TotalTime', subBuilder: $4.Duration.create)
    ..aOM<ProtoAirpump>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AirPump', protoName: 'AirPump', subBuilder: ProtoAirpump.create)
    ..pc<ProtoPatternDetail>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternDetail', $pb.PbFieldType.PM, protoName: 'PatternDetail', subBuilder: ProtoPatternDetail.create)
    ..aOM<$3.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CreateDate', protoName: 'CreateDate', subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ModifyDate', protoName: 'ModifyDate', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ProtoPattern._() : super();
  factory ProtoPattern({
    $core.int? patternId,
    $core.String? patternName,
    $core.int? stepCount,
    $4.Duration? totalTime,
    ProtoAirpump? airPump,
    $core.Iterable<ProtoPatternDetail>? patternDetail,
    $3.Timestamp? createDate,
    $3.Timestamp? modifyDate,
  }) {
    final _result = create();
    if (patternId != null) {
      _result.patternId = patternId;
    }
    if (patternName != null) {
      _result.patternName = patternName;
    }
    if (stepCount != null) {
      _result.stepCount = stepCount;
    }
    if (totalTime != null) {
      _result.totalTime = totalTime;
    }
    if (airPump != null) {
      _result.airPump = airPump;
    }
    if (patternDetail != null) {
      _result.patternDetail.addAll(patternDetail);
    }
    if (createDate != null) {
      _result.createDate = createDate;
    }
    if (modifyDate != null) {
      _result.modifyDate = modifyDate;
    }
    return _result;
  }
  factory ProtoPattern.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPattern.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPattern clone() => ProtoPattern()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPattern copyWith(void Function(ProtoPattern) updates) => super.copyWith((message) => updates(message as ProtoPattern)) as ProtoPattern; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPattern create() => ProtoPattern._();
  ProtoPattern createEmptyInstance() => create();
  static $pb.PbList<ProtoPattern> createRepeated() => $pb.PbList<ProtoPattern>();
  @$core.pragma('dart2js:noInline')
  static ProtoPattern getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPattern>(create);
  static ProtoPattern? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get patternId => $_getIZ(0);
  @$pb.TagNumber(1)
  set patternId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPatternId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPatternId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get patternName => $_getSZ(1);
  @$pb.TagNumber(2)
  set patternName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPatternName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPatternName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get stepCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set stepCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStepCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepCount() => clearField(3);

  @$pb.TagNumber(4)
  $4.Duration get totalTime => $_getN(3);
  @$pb.TagNumber(4)
  set totalTime($4.Duration v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalTime() => clearField(4);
  @$pb.TagNumber(4)
  $4.Duration ensureTotalTime() => $_ensure(3);

  @$pb.TagNumber(5)
  ProtoAirpump get airPump => $_getN(4);
  @$pb.TagNumber(5)
  set airPump(ProtoAirpump v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAirPump() => $_has(4);
  @$pb.TagNumber(5)
  void clearAirPump() => clearField(5);
  @$pb.TagNumber(5)
  ProtoAirpump ensureAirPump() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<ProtoPatternDetail> get patternDetail => $_getList(5);

  @$pb.TagNumber(7)
  $3.Timestamp get createDate => $_getN(6);
  @$pb.TagNumber(7)
  set createDate($3.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreateDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreateDate() => clearField(7);
  @$pb.TagNumber(7)
  $3.Timestamp ensureCreateDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $3.Timestamp get modifyDate => $_getN(7);
  @$pb.TagNumber(8)
  set modifyDate($3.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasModifyDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearModifyDate() => clearField(8);
  @$pb.TagNumber(8)
  $3.Timestamp ensureModifyDate() => $_ensure(7);
}

class ProtoAirpump extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoAirpump', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', $pb.PbFieldType.O3, protoName: 'Id')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StartTemp', $pb.PbFieldType.O3, protoName: 'StartTemp')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'EndTemp', $pb.PbFieldType.O3, protoName: 'EndTemp')
    ..aOM<$4.Duration>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DelayMinuteDuration', protoName: 'DelayMinuteDuration', subBuilder: $4.Duration.create)
    ..hasRequiredFields = false
  ;

  ProtoAirpump._() : super();
  factory ProtoAirpump({
    $core.int? id,
    $core.int? startTemp,
    $core.int? endTemp,
    $4.Duration? delayMinuteDuration,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (startTemp != null) {
      _result.startTemp = startTemp;
    }
    if (endTemp != null) {
      _result.endTemp = endTemp;
    }
    if (delayMinuteDuration != null) {
      _result.delayMinuteDuration = delayMinuteDuration;
    }
    return _result;
  }
  factory ProtoAirpump.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoAirpump.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoAirpump clone() => ProtoAirpump()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoAirpump copyWith(void Function(ProtoAirpump) updates) => super.copyWith((message) => updates(message as ProtoAirpump)) as ProtoAirpump; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoAirpump create() => ProtoAirpump._();
  ProtoAirpump createEmptyInstance() => create();
  static $pb.PbList<ProtoAirpump> createRepeated() => $pb.PbList<ProtoAirpump>();
  @$core.pragma('dart2js:noInline')
  static ProtoAirpump getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoAirpump>(create);
  static ProtoAirpump? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(3)
  $core.int get startTemp => $_getIZ(1);
  @$pb.TagNumber(3)
  set startTemp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartTemp() => $_has(1);
  @$pb.TagNumber(3)
  void clearStartTemp() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get endTemp => $_getIZ(2);
  @$pb.TagNumber(4)
  set endTemp($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndTemp() => $_has(2);
  @$pb.TagNumber(4)
  void clearEndTemp() => clearField(4);

  @$pb.TagNumber(5)
  $4.Duration get delayMinuteDuration => $_getN(3);
  @$pb.TagNumber(5)
  set delayMinuteDuration($4.Duration v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDelayMinuteDuration() => $_has(3);
  @$pb.TagNumber(5)
  void clearDelayMinuteDuration() => clearField(5);
  @$pb.TagNumber(5)
  $4.Duration ensureDelayMinuteDuration() => $_ensure(3);
}

class ProtoPatternDetail extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPatternDetail', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DetailId', $pb.PbFieldType.O3, protoName: 'DetailId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternId', $pb.PbFieldType.O3, protoName: 'PatternId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Step', $pb.PbFieldType.O3, protoName: 'Step')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Temp', $pb.PbFieldType.O3, protoName: 'Temp')
    ..aOM<$4.Duration>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StepDuration', protoName: 'StepDuration', subBuilder: $4.Duration.create)
    ..hasRequiredFields = false
  ;

  ProtoPatternDetail._() : super();
  factory ProtoPatternDetail({
    $core.int? detailId,
    $core.int? patternId,
    $core.int? step,
    $core.int? temp,
    $4.Duration? stepDuration,
  }) {
    final _result = create();
    if (detailId != null) {
      _result.detailId = detailId;
    }
    if (patternId != null) {
      _result.patternId = patternId;
    }
    if (step != null) {
      _result.step = step;
    }
    if (temp != null) {
      _result.temp = temp;
    }
    if (stepDuration != null) {
      _result.stepDuration = stepDuration;
    }
    return _result;
  }
  factory ProtoPatternDetail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPatternDetail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPatternDetail clone() => ProtoPatternDetail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPatternDetail copyWith(void Function(ProtoPatternDetail) updates) => super.copyWith((message) => updates(message as ProtoPatternDetail)) as ProtoPatternDetail; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPatternDetail create() => ProtoPatternDetail._();
  ProtoPatternDetail createEmptyInstance() => create();
  static $pb.PbList<ProtoPatternDetail> createRepeated() => $pb.PbList<ProtoPatternDetail>();
  @$core.pragma('dart2js:noInline')
  static ProtoPatternDetail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPatternDetail>(create);
  static ProtoPatternDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get detailId => $_getIZ(0);
  @$pb.TagNumber(1)
  set detailId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDetailId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDetailId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get patternId => $_getIZ(1);
  @$pb.TagNumber(2)
  set patternId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPatternId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPatternId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get step => $_getIZ(2);
  @$pb.TagNumber(3)
  set step($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStep() => $_has(2);
  @$pb.TagNumber(3)
  void clearStep() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get temp => $_getIZ(3);
  @$pb.TagNumber(4)
  set temp($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTemp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTemp() => clearField(4);

  @$pb.TagNumber(5)
  $4.Duration get stepDuration => $_getN(4);
  @$pb.TagNumber(5)
  set stepDuration($4.Duration v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStepDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearStepDuration() => clearField(5);
  @$pb.TagNumber(5)
  $4.Duration ensureStepDuration() => $_ensure(4);
}

class ProtoPatternList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPatternList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..pc<ProtoPattern>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Pattern', $pb.PbFieldType.PM, protoName: 'Pattern', subBuilder: ProtoPattern.create)
    ..hasRequiredFields = false
  ;

  ProtoPatternList._() : super();
  factory ProtoPatternList({
    $core.Iterable<ProtoPattern>? pattern,
  }) {
    final _result = create();
    if (pattern != null) {
      _result.pattern.addAll(pattern);
    }
    return _result;
  }
  factory ProtoPatternList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoPatternList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoPatternList clone() => ProtoPatternList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoPatternList copyWith(void Function(ProtoPatternList) updates) => super.copyWith((message) => updates(message as ProtoPatternList)) as ProtoPatternList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoPatternList create() => ProtoPatternList._();
  ProtoPatternList createEmptyInstance() => create();
  static $pb.PbList<ProtoPatternList> createRepeated() => $pb.PbList<ProtoPatternList>();
  @$core.pragma('dart2js:noInline')
  static ProtoPatternList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoPatternList>(create);
  static ProtoPatternList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProtoPattern> get pattern => $_getList(0);
}


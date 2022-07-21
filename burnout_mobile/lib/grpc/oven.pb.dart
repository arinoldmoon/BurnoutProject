///
//  Generated code. Do not modify.
//  source: oven.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $3;
import 'google/protobuf/duration.pb.dart' as $4;

import 'oven.pbenum.dart';

export 'oven.pbenum.dart';

class OperationLogWithFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OperationLogWithFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'YearSelect', $pb.PbFieldType.O3, protoName: 'YearSelect')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MonthSelect', $pb.PbFieldType.O3, protoName: 'MonthSelect')
    ..hasRequiredFields = false
  ;

  OperationLogWithFilter._() : super();
  factory OperationLogWithFilter({
    $core.int? yearSelect,
    $core.int? monthSelect,
  }) {
    final _result = create();
    if (yearSelect != null) {
      _result.yearSelect = yearSelect;
    }
    if (monthSelect != null) {
      _result.monthSelect = monthSelect;
    }
    return _result;
  }
  factory OperationLogWithFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OperationLogWithFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OperationLogWithFilter clone() => OperationLogWithFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OperationLogWithFilter copyWith(void Function(OperationLogWithFilter) updates) => super.copyWith((message) => updates(message as OperationLogWithFilter)) as OperationLogWithFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OperationLogWithFilter create() => OperationLogWithFilter._();
  OperationLogWithFilter createEmptyInstance() => create();
  static $pb.PbList<OperationLogWithFilter> createRepeated() => $pb.PbList<OperationLogWithFilter>();
  @$core.pragma('dart2js:noInline')
  static OperationLogWithFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OperationLogWithFilter>(create);
  static OperationLogWithFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get yearSelect => $_getIZ(0);
  @$pb.TagNumber(1)
  set yearSelect($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasYearSelect() => $_has(0);
  @$pb.TagNumber(1)
  void clearYearSelect() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get monthSelect => $_getIZ(1);
  @$pb.TagNumber(2)
  set monthSelect($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonthSelect() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonthSelect() => clearField(2);
}

class ProtoServiceConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoServiceConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PlcConnected', protoName: 'PlcConnected')
    ..aOM<ProtoOvenInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'OvenInfo', protoName: 'OvenInfo', subBuilder: ProtoOvenInfo.create)
    ..aOM<ProtoOperationLogInfo>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'OperationLogInfo', protoName: 'OperationLogInfo', subBuilder: ProtoOperationLogInfo.create)
    ..hasRequiredFields = false
  ;

  ProtoServiceConnection._() : super();
  factory ProtoServiceConnection({
    $core.bool? plcConnected,
    ProtoOvenInfo? ovenInfo,
    ProtoOperationLogInfo? operationLogInfo,
  }) {
    final _result = create();
    if (plcConnected != null) {
      _result.plcConnected = plcConnected;
    }
    if (ovenInfo != null) {
      _result.ovenInfo = ovenInfo;
    }
    if (operationLogInfo != null) {
      _result.operationLogInfo = operationLogInfo;
    }
    return _result;
  }
  factory ProtoServiceConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoServiceConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoServiceConnection clone() => ProtoServiceConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoServiceConnection copyWith(void Function(ProtoServiceConnection) updates) => super.copyWith((message) => updates(message as ProtoServiceConnection)) as ProtoServiceConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoServiceConnection create() => ProtoServiceConnection._();
  ProtoServiceConnection createEmptyInstance() => create();
  static $pb.PbList<ProtoServiceConnection> createRepeated() => $pb.PbList<ProtoServiceConnection>();
  @$core.pragma('dart2js:noInline')
  static ProtoServiceConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoServiceConnection>(create);
  static ProtoServiceConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get plcConnected => $_getBF(0);
  @$pb.TagNumber(1)
  set plcConnected($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlcConnected() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlcConnected() => clearField(1);

  @$pb.TagNumber(2)
  ProtoOvenInfo get ovenInfo => $_getN(1);
  @$pb.TagNumber(2)
  set ovenInfo(ProtoOvenInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOvenInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearOvenInfo() => clearField(2);
  @$pb.TagNumber(2)
  ProtoOvenInfo ensureOvenInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  ProtoOperationLogInfo get operationLogInfo => $_getN(2);
  @$pb.TagNumber(3)
  set operationLogInfo(ProtoOperationLogInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOperationLogInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearOperationLogInfo() => clearField(3);
  @$pb.TagNumber(3)
  ProtoOperationLogInfo ensureOperationLogInfo() => $_ensure(2);
}

class ProtoOvenInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SerialNumber', $pb.PbFieldType.O3, protoName: 'SerialNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MachineName', protoName: 'MachineName')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MachineModel', $pb.PbFieldType.O3, protoName: 'MachineModel')
    ..aOM<$3.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'WarrantyStart', protoName: 'WarrantyStart', subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'WarrantyEnd', protoName: 'WarrantyEnd', subBuilder: $3.Timestamp.create)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Operation', protoName: 'Operation')
    ..hasRequiredFields = false
  ;

  ProtoOvenInfo._() : super();
  factory ProtoOvenInfo({
    $core.int? serialNumber,
    $core.String? machineName,
    $core.int? machineModel,
    $3.Timestamp? warrantyStart,
    $3.Timestamp? warrantyEnd,
    $core.bool? operation,
  }) {
    final _result = create();
    if (serialNumber != null) {
      _result.serialNumber = serialNumber;
    }
    if (machineName != null) {
      _result.machineName = machineName;
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
    if (operation != null) {
      _result.operation = operation;
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
  $core.String get machineName => $_getSZ(1);
  @$pb.TagNumber(2)
  set machineName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMachineName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMachineName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get machineModel => $_getIZ(2);
  @$pb.TagNumber(3)
  set machineModel($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMachineModel() => $_has(2);
  @$pb.TagNumber(3)
  void clearMachineModel() => clearField(3);

  @$pb.TagNumber(4)
  $3.Timestamp get warrantyStart => $_getN(3);
  @$pb.TagNumber(4)
  set warrantyStart($3.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasWarrantyStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearWarrantyStart() => clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureWarrantyStart() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.Timestamp get warrantyEnd => $_getN(4);
  @$pb.TagNumber(5)
  set warrantyEnd($3.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasWarrantyEnd() => $_has(4);
  @$pb.TagNumber(5)
  void clearWarrantyEnd() => clearField(5);
  @$pb.TagNumber(5)
  $3.Timestamp ensureWarrantyEnd() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.bool get operation => $_getBF(5);
  @$pb.TagNumber(6)
  set operation($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOperation() => $_has(5);
  @$pb.TagNumber(6)
  void clearOperation() => clearField(6);
}

class ProtoOperationLogInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOperationLogInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'YearList', $pb.PbFieldType.K3, protoName: 'YearList')
    ..p<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MonthList', $pb.PbFieldType.K3, protoName: 'MonthList')
    ..pc<ProtoOvenLogList>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LogList', $pb.PbFieldType.PM, protoName: 'LogList', subBuilder: ProtoOvenLogList.create)
    ..hasRequiredFields = false
  ;

  ProtoOperationLogInfo._() : super();
  factory ProtoOperationLogInfo({
    $core.Iterable<$core.int>? yearList,
    $core.Iterable<$core.int>? monthList,
    $core.Iterable<ProtoOvenLogList>? logList,
  }) {
    final _result = create();
    if (yearList != null) {
      _result.yearList.addAll(yearList);
    }
    if (monthList != null) {
      _result.monthList.addAll(monthList);
    }
    if (logList != null) {
      _result.logList.addAll(logList);
    }
    return _result;
  }
  factory ProtoOperationLogInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoOperationLogInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoOperationLogInfo clone() => ProtoOperationLogInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoOperationLogInfo copyWith(void Function(ProtoOperationLogInfo) updates) => super.copyWith((message) => updates(message as ProtoOperationLogInfo)) as ProtoOperationLogInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoOperationLogInfo create() => ProtoOperationLogInfo._();
  ProtoOperationLogInfo createEmptyInstance() => create();
  static $pb.PbList<ProtoOperationLogInfo> createRepeated() => $pb.PbList<ProtoOperationLogInfo>();
  @$core.pragma('dart2js:noInline')
  static ProtoOperationLogInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoOperationLogInfo>(create);
  static ProtoOperationLogInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get yearList => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get monthList => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<ProtoOvenLogList> get logList => $_getList(2);
}

class ProtoOvenLogList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenLogList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LogID', $pb.PbFieldType.O3, protoName: 'LogID')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternID', $pb.PbFieldType.O3, protoName: 'PatternID')
    ..aOM<$3.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StartLog', protoName: 'StartLog', subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'EndLog', protoName: 'EndLog', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ProtoOvenLogList._() : super();
  factory ProtoOvenLogList({
    $core.int? logID,
    $core.int? patternID,
    $3.Timestamp? startLog,
    $3.Timestamp? endLog,
  }) {
    final _result = create();
    if (logID != null) {
      _result.logID = logID;
    }
    if (patternID != null) {
      _result.patternID = patternID;
    }
    if (startLog != null) {
      _result.startLog = startLog;
    }
    if (endLog != null) {
      _result.endLog = endLog;
    }
    return _result;
  }
  factory ProtoOvenLogList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoOvenLogList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoOvenLogList clone() => ProtoOvenLogList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoOvenLogList copyWith(void Function(ProtoOvenLogList) updates) => super.copyWith((message) => updates(message as ProtoOvenLogList)) as ProtoOvenLogList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoOvenLogList create() => ProtoOvenLogList._();
  ProtoOvenLogList createEmptyInstance() => create();
  static $pb.PbList<ProtoOvenLogList> createRepeated() => $pb.PbList<ProtoOvenLogList>();
  @$core.pragma('dart2js:noInline')
  static ProtoOvenLogList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoOvenLogList>(create);
  static ProtoOvenLogList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get logID => $_getIZ(0);
  @$pb.TagNumber(1)
  set logID($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLogID() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogID() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get patternID => $_getIZ(1);
  @$pb.TagNumber(2)
  set patternID($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPatternID() => $_has(1);
  @$pb.TagNumber(2)
  void clearPatternID() => clearField(2);

  @$pb.TagNumber(3)
  $3.Timestamp get startLog => $_getN(2);
  @$pb.TagNumber(3)
  set startLog($3.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartLog() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartLog() => clearField(3);
  @$pb.TagNumber(3)
  $3.Timestamp ensureStartLog() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Timestamp get endLog => $_getN(3);
  @$pb.TagNumber(4)
  set endLog($3.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndLog() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndLog() => clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureEndLog() => $_ensure(3);
}

class ProtoOvenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOM<Temp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Temp', protoName: 'Temp', subBuilder: Temp.create)
    ..aOM<Coil>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Coil', protoName: 'Coil', subBuilder: Coil.create)
    ..aOM<MachineStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Status', protoName: 'Status', subBuilder: MachineStatus.create)
    ..hasRequiredFields = false
  ;

  ProtoOvenResponse._() : super();
  factory ProtoOvenResponse({
    Temp? temp,
    Coil? coil,
    MachineStatus? status,
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
  MachineStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(MachineStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
  @$pb.TagNumber(3)
  MachineStatus ensureStatus() => $_ensure(2);
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

class MachineStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MachineStatus', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Door', protoName: 'Door')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Operation', protoName: 'Operation')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternId', $pb.PbFieldType.O3, protoName: 'PatternId')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TotalStep', $pb.PbFieldType.O3, protoName: 'TotalStep')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CurrentStep', $pb.PbFieldType.O3, protoName: 'CurrentStep')
    ..e<PatternStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternStatus', $pb.PbFieldType.OE, protoName: 'PatternStatus', defaultOrMaker: PatternStatus.Standby, valueOf: PatternStatus.valueOf, enumValues: PatternStatus.values)
    ..aOM<$4.Duration>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RemainHours', protoName: 'RemainHours', subBuilder: $4.Duration.create)
    ..aOM<$4.Duration>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RemainMins', protoName: 'RemainMins', subBuilder: $4.Duration.create)
    ..aOM<ActualLogList>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempLogList', protoName: 'TempLogList', subBuilder: ActualLogList.create)
    ..hasRequiredFields = false
  ;

  MachineStatus._() : super();
  factory MachineStatus({
    $core.bool? door,
    $core.bool? operation,
    $core.int? patternId,
    $core.int? totalStep,
    $core.int? currentStep,
    PatternStatus? patternStatus,
    $4.Duration? remainHours,
    $4.Duration? remainMins,
    ActualLogList? tempLogList,
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
    if (tempLogList != null) {
      _result.tempLogList = tempLogList;
    }
    return _result;
  }
  factory MachineStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MachineStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MachineStatus clone() => MachineStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MachineStatus copyWith(void Function(MachineStatus) updates) => super.copyWith((message) => updates(message as MachineStatus)) as MachineStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MachineStatus create() => MachineStatus._();
  MachineStatus createEmptyInstance() => create();
  static $pb.PbList<MachineStatus> createRepeated() => $pb.PbList<MachineStatus>();
  @$core.pragma('dart2js:noInline')
  static MachineStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MachineStatus>(create);
  static MachineStatus? _defaultInstance;

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

  @$pb.TagNumber(9)
  ActualLogList get tempLogList => $_getN(8);
  @$pb.TagNumber(9)
  set tempLogList(ActualLogList v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTempLogList() => $_has(8);
  @$pb.TagNumber(9)
  void clearTempLogList() => clearField(9);
  @$pb.TagNumber(9)
  ActualLogList ensureTempLogList() => $_ensure(8);
}

class ActualLogList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActualLogList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..pc<ActualLog>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempLog', $pb.PbFieldType.PM, protoName: 'TempLog', subBuilder: ActualLog.create)
    ..hasRequiredFields = false
  ;

  ActualLogList._() : super();
  factory ActualLogList({
    $core.Iterable<ActualLog>? tempLog,
  }) {
    final _result = create();
    if (tempLog != null) {
      _result.tempLog.addAll(tempLog);
    }
    return _result;
  }
  factory ActualLogList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActualLogList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActualLogList clone() => ActualLogList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActualLogList copyWith(void Function(ActualLogList) updates) => super.copyWith((message) => updates(message as ActualLogList)) as ActualLogList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActualLogList create() => ActualLogList._();
  ActualLogList createEmptyInstance() => create();
  static $pb.PbList<ActualLogList> createRepeated() => $pb.PbList<ActualLogList>();
  @$core.pragma('dart2js:noInline')
  static ActualLogList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActualLogList>(create);
  static ActualLogList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ActualLog> get tempLog => $_getList(0);
}

class ActualLog extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActualLog', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOM<$3.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempTime', protoName: 'TempTime', subBuilder: $3.Timestamp.create)
    ..aOM<Temp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TempValue', protoName: 'TempValue', subBuilder: Temp.create)
    ..hasRequiredFields = false
  ;

  ActualLog._() : super();
  factory ActualLog({
    $3.Timestamp? tempTime,
    Temp? tempValue,
  }) {
    final _result = create();
    if (tempTime != null) {
      _result.tempTime = tempTime;
    }
    if (tempValue != null) {
      _result.tempValue = tempValue;
    }
    return _result;
  }
  factory ActualLog.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActualLog.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActualLog clone() => ActualLog()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActualLog copyWith(void Function(ActualLog) updates) => super.copyWith((message) => updates(message as ActualLog)) as ActualLog; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActualLog create() => ActualLog._();
  ActualLog createEmptyInstance() => create();
  static $pb.PbList<ActualLog> createRepeated() => $pb.PbList<ActualLog>();
  @$core.pragma('dart2js:noInline')
  static ActualLog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActualLog>(create);
  static ActualLog? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Timestamp get tempTime => $_getN(0);
  @$pb.TagNumber(1)
  set tempTime($3.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTempTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTempTime() => clearField(1);
  @$pb.TagNumber(1)
  $3.Timestamp ensureTempTime() => $_ensure(0);

  @$pb.TagNumber(2)
  Temp get tempValue => $_getN(1);
  @$pb.TagNumber(2)
  set tempValue(Temp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTempValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTempValue() => clearField(2);
  @$pb.TagNumber(2)
  Temp ensureTempValue() => $_ensure(1);
}

class ProtoOvenSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoOvenSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AfbStartTemp', $pb.PbFieldType.O3, protoName: 'AfbStartTemp')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AfbEndTemp', $pb.PbFieldType.O3, protoName: 'AfbEndTemp')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AfbDelay', $pb.PbFieldType.O3, protoName: 'AfbDelay')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TubeStartTemp', $pb.PbFieldType.O3, protoName: 'TubeStartTemp')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FloorStartTemp', $pb.PbFieldType.O3, protoName: 'FloorStartTemp')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AlarmOven', $pb.PbFieldType.O3, protoName: 'AlarmOven')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AlarmAfb', $pb.PbFieldType.O3, protoName: 'AlarmAfb')
    ..aOM<Temp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SetpointTemp', protoName: 'SetpointTemp', subBuilder: Temp.create)
    ..aOM<Coil>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CoilSetting', protoName: 'CoilSetting', subBuilder: Coil.create)
    ..aOM<ProtoManualTemp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ManualTemp', protoName: 'ManualTemp', subBuilder: ProtoManualTemp.create)
    ..hasRequiredFields = false
  ;

  ProtoOvenSetting._() : super();
  factory ProtoOvenSetting({
    $core.int? afbStartTemp,
    $core.int? afbEndTemp,
    $core.int? afbDelay,
    $core.int? tubeStartTemp,
    $core.int? floorStartTemp,
    $core.int? alarmOven,
    $core.int? alarmAfb,
    Temp? setpointTemp,
    Coil? coilSetting,
    ProtoManualTemp? manualTemp,
  }) {
    final _result = create();
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
    if (setpointTemp != null) {
      _result.setpointTemp = setpointTemp;
    }
    if (coilSetting != null) {
      _result.coilSetting = coilSetting;
    }
    if (manualTemp != null) {
      _result.manualTemp = manualTemp;
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
  $core.int get afbStartTemp => $_getIZ(0);
  @$pb.TagNumber(1)
  set afbStartTemp($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAfbStartTemp() => $_has(0);
  @$pb.TagNumber(1)
  void clearAfbStartTemp() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get afbEndTemp => $_getIZ(1);
  @$pb.TagNumber(2)
  set afbEndTemp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAfbEndTemp() => $_has(1);
  @$pb.TagNumber(2)
  void clearAfbEndTemp() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get afbDelay => $_getIZ(2);
  @$pb.TagNumber(3)
  set afbDelay($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAfbDelay() => $_has(2);
  @$pb.TagNumber(3)
  void clearAfbDelay() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get tubeStartTemp => $_getIZ(3);
  @$pb.TagNumber(4)
  set tubeStartTemp($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTubeStartTemp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTubeStartTemp() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get floorStartTemp => $_getIZ(4);
  @$pb.TagNumber(5)
  set floorStartTemp($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFloorStartTemp() => $_has(4);
  @$pb.TagNumber(5)
  void clearFloorStartTemp() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get alarmOven => $_getIZ(5);
  @$pb.TagNumber(6)
  set alarmOven($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAlarmOven() => $_has(5);
  @$pb.TagNumber(6)
  void clearAlarmOven() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get alarmAfb => $_getIZ(6);
  @$pb.TagNumber(7)
  set alarmAfb($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAlarmAfb() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlarmAfb() => clearField(7);

  @$pb.TagNumber(8)
  Temp get setpointTemp => $_getN(7);
  @$pb.TagNumber(8)
  set setpointTemp(Temp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasSetpointTemp() => $_has(7);
  @$pb.TagNumber(8)
  void clearSetpointTemp() => clearField(8);
  @$pb.TagNumber(8)
  Temp ensureSetpointTemp() => $_ensure(7);

  @$pb.TagNumber(9)
  Coil get coilSetting => $_getN(8);
  @$pb.TagNumber(9)
  set coilSetting(Coil v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCoilSetting() => $_has(8);
  @$pb.TagNumber(9)
  void clearCoilSetting() => clearField(9);
  @$pb.TagNumber(9)
  Coil ensureCoilSetting() => $_ensure(8);

  @$pb.TagNumber(10)
  ProtoManualTemp get manualTemp => $_getN(9);
  @$pb.TagNumber(10)
  set manualTemp(ProtoManualTemp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasManualTemp() => $_has(9);
  @$pb.TagNumber(10)
  void clearManualTemp() => clearField(10);
  @$pb.TagNumber(10)
  ProtoManualTemp ensureManualTemp() => $_ensure(9);
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

class ProtoPattern extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoPattern', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternId', $pb.PbFieldType.O3, protoName: 'PatternId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternName', protoName: 'PatternName')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StepCount', $pb.PbFieldType.O3, protoName: 'StepCount')
    ..aOM<$4.Duration>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TotalTime', protoName: 'TotalTime', subBuilder: $4.Duration.create)
    ..aOM<ProtoAirpump>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AirPump', protoName: 'AirPump', subBuilder: ProtoAirpump.create)
    ..pc<ProtoPatternDetail>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PatternDetail', $pb.PbFieldType.PM, protoName: 'PatternDetail', subBuilder: ProtoPatternDetail.create)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UseAfb', protoName: 'UseAfb')
    ..aOM<$3.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CreateDate', protoName: 'CreateDate', subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ModifyDate', protoName: 'ModifyDate', subBuilder: $3.Timestamp.create)
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
    $core.bool? useAfb,
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
    if (useAfb != null) {
      _result.useAfb = useAfb;
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
  $core.bool get useAfb => $_getBF(6);
  @$pb.TagNumber(7)
  set useAfb($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUseAfb() => $_has(6);
  @$pb.TagNumber(7)
  void clearUseAfb() => clearField(7);

  @$pb.TagNumber(8)
  $3.Timestamp get createDate => $_getN(7);
  @$pb.TagNumber(8)
  set createDate($3.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreateDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreateDate() => clearField(8);
  @$pb.TagNumber(8)
  $3.Timestamp ensureCreateDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $3.Timestamp get modifyDate => $_getN(8);
  @$pb.TagNumber(9)
  set modifyDate($3.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasModifyDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearModifyDate() => clearField(9);
  @$pb.TagNumber(9)
  $3.Timestamp ensureModifyDate() => $_ensure(8);
}

class ProtoAirpump extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoAirpump', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', $pb.PbFieldType.O3, protoName: 'Id')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'StartTemp', $pb.PbFieldType.O3, protoName: 'StartTemp')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'EndTemp', $pb.PbFieldType.O3, protoName: 'EndTemp')
    ..aOM<$4.Duration>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DelayMinuteDuration', protoName: 'DelayMinuteDuration', subBuilder: $4.Duration.create)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UseAirpump', protoName: 'UseAirpump')
    ..hasRequiredFields = false
  ;

  ProtoAirpump._() : super();
  factory ProtoAirpump({
    $core.int? id,
    $core.int? startTemp,
    $core.int? endTemp,
    $4.Duration? delayMinuteDuration,
    $core.bool? useAirpump,
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
    if (useAirpump != null) {
      _result.useAirpump = useAirpump;
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

  @$pb.TagNumber(2)
  $core.int get startTemp => $_getIZ(1);
  @$pb.TagNumber(2)
  set startTemp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartTemp() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTemp() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get endTemp => $_getIZ(2);
  @$pb.TagNumber(3)
  set endTemp($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndTemp() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndTemp() => clearField(3);

  @$pb.TagNumber(4)
  $4.Duration get delayMinuteDuration => $_getN(3);
  @$pb.TagNumber(4)
  set delayMinuteDuration($4.Duration v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDelayMinuteDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDelayMinuteDuration() => clearField(4);
  @$pb.TagNumber(4)
  $4.Duration ensureDelayMinuteDuration() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get useAirpump => $_getBF(4);
  @$pb.TagNumber(5)
  set useAirpump($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUseAirpump() => $_has(4);
  @$pb.TagNumber(5)
  void clearUseAirpump() => clearField(5);
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

class ProtoManualTemp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoManualTemp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Oven'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Use', protoName: 'Use')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Temp', $pb.PbFieldType.O3, protoName: 'Temp')
    ..hasRequiredFields = false
  ;

  ProtoManualTemp._() : super();
  factory ProtoManualTemp({
    $core.bool? use,
    $core.int? temp,
  }) {
    final _result = create();
    if (use != null) {
      _result.use = use;
    }
    if (temp != null) {
      _result.temp = temp;
    }
    return _result;
  }
  factory ProtoManualTemp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoManualTemp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoManualTemp clone() => ProtoManualTemp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoManualTemp copyWith(void Function(ProtoManualTemp) updates) => super.copyWith((message) => updates(message as ProtoManualTemp)) as ProtoManualTemp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoManualTemp create() => ProtoManualTemp._();
  ProtoManualTemp createEmptyInstance() => create();
  static $pb.PbList<ProtoManualTemp> createRepeated() => $pb.PbList<ProtoManualTemp>();
  @$core.pragma('dart2js:noInline')
  static ProtoManualTemp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoManualTemp>(create);
  static ProtoManualTemp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get use => $_getBF(0);
  @$pb.TagNumber(1)
  set use($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUse() => $_has(0);
  @$pb.TagNumber(1)
  void clearUse() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get temp => $_getIZ(1);
  @$pb.TagNumber(2)
  set temp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTemp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTemp() => clearField(2);
}


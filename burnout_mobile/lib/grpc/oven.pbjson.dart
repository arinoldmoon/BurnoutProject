///
//  Generated code. Do not modify.
//  source: oven.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use patternStatusDescriptor instead')
const PatternStatus$json = const {
  '1': 'PatternStatus',
  '2': const [
    const {'1': 'Standby', '2': 0},
    const {'1': 'Up', '2': 1},
    const {'1': 'Down', '2': 2},
    const {'1': 'Stable', '2': 3},
    const {'1': 'End', '2': 4},
  ],
};

/// Descriptor for `PatternStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List patternStatusDescriptor = $convert.base64Decode('Cg1QYXR0ZXJuU3RhdHVzEgsKB1N0YW5kYnkQABIGCgJVcBABEggKBERvd24QAhIKCgZTdGFibGUQAxIHCgNFbmQQBA==');
@$core.Deprecated('Use operationLogWithFilterDescriptor instead')
const OperationLogWithFilter$json = const {
  '1': 'OperationLogWithFilter',
  '2': const [
    const {'1': 'YearSelect', '3': 1, '4': 1, '5': 5, '10': 'YearSelect'},
    const {'1': 'MonthSelect', '3': 2, '4': 1, '5': 5, '10': 'MonthSelect'},
  ],
};

/// Descriptor for `OperationLogWithFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationLogWithFilterDescriptor = $convert.base64Decode('ChZPcGVyYXRpb25Mb2dXaXRoRmlsdGVyEh4KClllYXJTZWxlY3QYASABKAVSClllYXJTZWxlY3QSIAoLTW9udGhTZWxlY3QYAiABKAVSC01vbnRoU2VsZWN0');
@$core.Deprecated('Use protoServiceConnectionDescriptor instead')
const ProtoServiceConnection$json = const {
  '1': 'ProtoServiceConnection',
  '2': const [
    const {'1': 'PlcConnected', '3': 1, '4': 1, '5': 8, '10': 'PlcConnected'},
    const {'1': 'OvenInfo', '3': 2, '4': 1, '5': 11, '6': '.Oven.ProtoOvenInfo', '10': 'OvenInfo'},
    const {'1': 'OperationLogInfo', '3': 3, '4': 1, '5': 11, '6': '.Oven.ProtoOperationLogInfo', '10': 'OperationLogInfo'},
  ],
};

/// Descriptor for `ProtoServiceConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoServiceConnectionDescriptor = $convert.base64Decode('ChZQcm90b1NlcnZpY2VDb25uZWN0aW9uEiIKDFBsY0Nvbm5lY3RlZBgBIAEoCFIMUGxjQ29ubmVjdGVkEi8KCE92ZW5JbmZvGAIgASgLMhMuT3Zlbi5Qcm90b092ZW5JbmZvUghPdmVuSW5mbxJHChBPcGVyYXRpb25Mb2dJbmZvGAMgASgLMhsuT3Zlbi5Qcm90b09wZXJhdGlvbkxvZ0luZm9SEE9wZXJhdGlvbkxvZ0luZm8=');
@$core.Deprecated('Use protoOvenInfoDescriptor instead')
const ProtoOvenInfo$json = const {
  '1': 'ProtoOvenInfo',
  '2': const [
    const {'1': 'SerialNumber', '3': 1, '4': 1, '5': 5, '10': 'SerialNumber'},
    const {'1': 'MachineModel', '3': 2, '4': 1, '5': 5, '10': 'MachineModel'},
    const {'1': 'WarrantyStart', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'WarrantyStart'},
    const {'1': 'WarrantyEnd', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'WarrantyEnd'},
    const {'1': 'MachineName', '3': 5, '4': 1, '5': 9, '10': 'MachineName'},
  ],
};

/// Descriptor for `ProtoOvenInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOvenInfoDescriptor = $convert.base64Decode('Cg1Qcm90b092ZW5JbmZvEiIKDFNlcmlhbE51bWJlchgBIAEoBVIMU2VyaWFsTnVtYmVyEiIKDE1hY2hpbmVNb2RlbBgCIAEoBVIMTWFjaGluZU1vZGVsEkAKDVdhcnJhbnR5U3RhcnQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg1XYXJyYW50eVN0YXJ0EjwKC1dhcnJhbnR5RW5kGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILV2FycmFudHlFbmQSIAoLTWFjaGluZU5hbWUYBSABKAlSC01hY2hpbmVOYW1l');
@$core.Deprecated('Use protoOperationLogInfoDescriptor instead')
const ProtoOperationLogInfo$json = const {
  '1': 'ProtoOperationLogInfo',
  '2': const [
    const {'1': 'YearList', '3': 1, '4': 3, '5': 5, '10': 'YearList'},
    const {'1': 'MonthList', '3': 2, '4': 3, '5': 5, '10': 'MonthList'},
    const {'1': 'LogList', '3': 3, '4': 3, '5': 11, '6': '.Oven.ProtoOvenLogList', '10': 'LogList'},
  ],
};

/// Descriptor for `ProtoOperationLogInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOperationLogInfoDescriptor = $convert.base64Decode('ChVQcm90b09wZXJhdGlvbkxvZ0luZm8SGgoIWWVhckxpc3QYASADKAVSCFllYXJMaXN0EhwKCU1vbnRoTGlzdBgCIAMoBVIJTW9udGhMaXN0EjAKB0xvZ0xpc3QYAyADKAsyFi5PdmVuLlByb3RvT3ZlbkxvZ0xpc3RSB0xvZ0xpc3Q=');
@$core.Deprecated('Use protoOvenLogListDescriptor instead')
const ProtoOvenLogList$json = const {
  '1': 'ProtoOvenLogList',
  '2': const [
    const {'1': 'LogID', '3': 1, '4': 1, '5': 5, '10': 'LogID'},
    const {'1': 'PatternID', '3': 2, '4': 1, '5': 5, '10': 'PatternID'},
    const {'1': 'StartLog', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'StartLog'},
    const {'1': 'EndLog', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'EndLog'},
  ],
};

/// Descriptor for `ProtoOvenLogList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOvenLogListDescriptor = $convert.base64Decode('ChBQcm90b092ZW5Mb2dMaXN0EhQKBUxvZ0lEGAEgASgFUgVMb2dJRBIcCglQYXR0ZXJuSUQYAiABKAVSCVBhdHRlcm5JRBI2CghTdGFydExvZxgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCFN0YXJ0TG9nEjIKBkVuZExvZxgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBkVuZExvZw==');
@$core.Deprecated('Use protoOvenResponseDescriptor instead')
const ProtoOvenResponse$json = const {
  '1': 'ProtoOvenResponse',
  '2': const [
    const {'1': 'Temp', '3': 1, '4': 1, '5': 11, '6': '.Oven.Temp', '10': 'Temp'},
    const {'1': 'Coil', '3': 2, '4': 1, '5': 11, '6': '.Oven.Coil', '10': 'Coil'},
    const {'1': 'Status', '3': 3, '4': 1, '5': 11, '6': '.Oven.MachineStatus', '10': 'Status'},
  ],
};

/// Descriptor for `ProtoOvenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOvenResponseDescriptor = $convert.base64Decode('ChFQcm90b092ZW5SZXNwb25zZRIeCgRUZW1wGAEgASgLMgouT3Zlbi5UZW1wUgRUZW1wEh4KBENvaWwYAiABKAsyCi5PdmVuLkNvaWxSBENvaWwSKwoGU3RhdHVzGAMgASgLMhMuT3Zlbi5NYWNoaW5lU3RhdHVzUgZTdGF0dXM=');
@$core.Deprecated('Use tempDescriptor instead')
const Temp$json = const {
  '1': 'Temp',
  '2': const [
    const {'1': 'TempOven', '3': 1, '4': 1, '5': 5, '10': 'TempOven'},
    const {'1': 'TempAFB', '3': 2, '4': 1, '5': 5, '10': 'TempAFB'},
    const {'1': 'TempTube', '3': 3, '4': 1, '5': 5, '10': 'TempTube'},
    const {'1': 'TempFloor', '3': 4, '4': 1, '5': 5, '10': 'TempFloor'},
  ],
};

/// Descriptor for `Temp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tempDescriptor = $convert.base64Decode('CgRUZW1wEhoKCFRlbXBPdmVuGAEgASgFUghUZW1wT3ZlbhIYCgdUZW1wQUZCGAIgASgFUgdUZW1wQUZCEhoKCFRlbXBUdWJlGAMgASgFUghUZW1wVHViZRIcCglUZW1wRmxvb3IYBCABKAVSCVRlbXBGbG9vcg==');
@$core.Deprecated('Use coilDescriptor instead')
const Coil$json = const {
  '1': 'Coil',
  '2': const [
    const {'1': 'CoilOven', '3': 1, '4': 1, '5': 8, '10': 'CoilOven'},
    const {'1': 'CoilAFB', '3': 2, '4': 1, '5': 8, '10': 'CoilAFB'},
    const {'1': 'CoilTube', '3': 3, '4': 1, '5': 8, '10': 'CoilTube'},
    const {'1': 'CoilPump', '3': 4, '4': 1, '5': 8, '10': 'CoilPump'},
    const {'1': 'CoilFloor', '3': 5, '4': 1, '5': 8, '10': 'CoilFloor'},
  ],
};

/// Descriptor for `Coil`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coilDescriptor = $convert.base64Decode('CgRDb2lsEhoKCENvaWxPdmVuGAEgASgIUghDb2lsT3ZlbhIYCgdDb2lsQUZCGAIgASgIUgdDb2lsQUZCEhoKCENvaWxUdWJlGAMgASgIUghDb2lsVHViZRIaCghDb2lsUHVtcBgEIAEoCFIIQ29pbFB1bXASHAoJQ29pbEZsb29yGAUgASgIUglDb2lsRmxvb3I=');
@$core.Deprecated('Use machineStatusDescriptor instead')
const MachineStatus$json = const {
  '1': 'MachineStatus',
  '2': const [
    const {'1': 'Door', '3': 1, '4': 1, '5': 8, '10': 'Door'},
    const {'1': 'Operation', '3': 2, '4': 1, '5': 8, '10': 'Operation'},
    const {'1': 'PatternId', '3': 3, '4': 1, '5': 5, '10': 'PatternId'},
    const {'1': 'TotalStep', '3': 4, '4': 1, '5': 5, '10': 'TotalStep'},
    const {'1': 'CurrentStep', '3': 5, '4': 1, '5': 5, '10': 'CurrentStep'},
    const {'1': 'PatternStatus', '3': 6, '4': 1, '5': 14, '6': '.Oven.PatternStatus', '10': 'PatternStatus'},
    const {'1': 'RemainHours', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'RemainHours'},
    const {'1': 'RemainMins', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'RemainMins'},
    const {'1': 'TempLogList', '3': 9, '4': 1, '5': 11, '6': '.Oven.ActualLogList', '10': 'TempLogList'},
  ],
};

/// Descriptor for `MachineStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List machineStatusDescriptor = $convert.base64Decode('Cg1NYWNoaW5lU3RhdHVzEhIKBERvb3IYASABKAhSBERvb3ISHAoJT3BlcmF0aW9uGAIgASgIUglPcGVyYXRpb24SHAoJUGF0dGVybklkGAMgASgFUglQYXR0ZXJuSWQSHAoJVG90YWxTdGVwGAQgASgFUglUb3RhbFN0ZXASIAoLQ3VycmVudFN0ZXAYBSABKAVSC0N1cnJlbnRTdGVwEjkKDVBhdHRlcm5TdGF0dXMYBiABKA4yEy5PdmVuLlBhdHRlcm5TdGF0dXNSDVBhdHRlcm5TdGF0dXMSOwoLUmVtYWluSG91cnMYByABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SC1JlbWFpbkhvdXJzEjkKClJlbWFpbk1pbnMYCCABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SClJlbWFpbk1pbnMSNQoLVGVtcExvZ0xpc3QYCSABKAsyEy5PdmVuLkFjdHVhbExvZ0xpc3RSC1RlbXBMb2dMaXN0');
@$core.Deprecated('Use actualLogListDescriptor instead')
const ActualLogList$json = const {
  '1': 'ActualLogList',
  '2': const [
    const {'1': 'TempLog', '3': 1, '4': 3, '5': 11, '6': '.Oven.ActualLog', '10': 'TempLog'},
  ],
};

/// Descriptor for `ActualLogList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actualLogListDescriptor = $convert.base64Decode('Cg1BY3R1YWxMb2dMaXN0EikKB1RlbXBMb2cYASADKAsyDy5PdmVuLkFjdHVhbExvZ1IHVGVtcExvZw==');
@$core.Deprecated('Use actualLogDescriptor instead')
const ActualLog$json = const {
  '1': 'ActualLog',
  '2': const [
    const {'1': 'TempTime', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'TempTime'},
    const {'1': 'TempValue', '3': 2, '4': 1, '5': 11, '6': '.Oven.Temp', '10': 'TempValue'},
  ],
};

/// Descriptor for `ActualLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actualLogDescriptor = $convert.base64Decode('CglBY3R1YWxMb2cSNgoIVGVtcFRpbWUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghUZW1wVGltZRIoCglUZW1wVmFsdWUYAiABKAsyCi5PdmVuLlRlbXBSCVRlbXBWYWx1ZQ==');
@$core.Deprecated('Use protoOvenSettingDescriptor instead')
const ProtoOvenSetting$json = const {
  '1': 'ProtoOvenSetting',
  '2': const [
    const {'1': 'AfbStartTemp', '3': 1, '4': 1, '5': 5, '10': 'AfbStartTemp'},
    const {'1': 'AfbEndTemp', '3': 2, '4': 1, '5': 5, '10': 'AfbEndTemp'},
    const {'1': 'AfbDelay', '3': 3, '4': 1, '5': 5, '10': 'AfbDelay'},
    const {'1': 'TubeStartTemp', '3': 4, '4': 1, '5': 5, '10': 'TubeStartTemp'},
    const {'1': 'FloorStartTemp', '3': 5, '4': 1, '5': 5, '10': 'FloorStartTemp'},
    const {'1': 'AlarmOven', '3': 6, '4': 1, '5': 5, '10': 'AlarmOven'},
    const {'1': 'AlarmAfb', '3': 7, '4': 1, '5': 5, '10': 'AlarmAfb'},
    const {'1': 'SetpointTemp', '3': 8, '4': 1, '5': 11, '6': '.Oven.Temp', '10': 'SetpointTemp'},
    const {'1': 'CoilSetting', '3': 9, '4': 1, '5': 11, '6': '.Oven.Coil', '10': 'CoilSetting'},
  ],
};

/// Descriptor for `ProtoOvenSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOvenSettingDescriptor = $convert.base64Decode('ChBQcm90b092ZW5TZXR0aW5nEiIKDEFmYlN0YXJ0VGVtcBgBIAEoBVIMQWZiU3RhcnRUZW1wEh4KCkFmYkVuZFRlbXAYAiABKAVSCkFmYkVuZFRlbXASGgoIQWZiRGVsYXkYAyABKAVSCEFmYkRlbGF5EiQKDVR1YmVTdGFydFRlbXAYBCABKAVSDVR1YmVTdGFydFRlbXASJgoORmxvb3JTdGFydFRlbXAYBSABKAVSDkZsb29yU3RhcnRUZW1wEhwKCUFsYXJtT3ZlbhgGIAEoBVIJQWxhcm1PdmVuEhoKCEFsYXJtQWZiGAcgASgFUghBbGFybUFmYhIuCgxTZXRwb2ludFRlbXAYCCABKAsyCi5PdmVuLlRlbXBSDFNldHBvaW50VGVtcBIsCgtDb2lsU2V0dGluZxgJIAEoCzIKLk92ZW4uQ29pbFILQ29pbFNldHRpbmc=');
@$core.Deprecated('Use protoPatternListDescriptor instead')
const ProtoPatternList$json = const {
  '1': 'ProtoPatternList',
  '2': const [
    const {'1': 'Pattern', '3': 1, '4': 3, '5': 11, '6': '.Oven.ProtoPattern', '10': 'Pattern'},
  ],
};

/// Descriptor for `ProtoPatternList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPatternListDescriptor = $convert.base64Decode('ChBQcm90b1BhdHRlcm5MaXN0EiwKB1BhdHRlcm4YASADKAsyEi5PdmVuLlByb3RvUGF0dGVyblIHUGF0dGVybg==');
@$core.Deprecated('Use protoPatternDescriptor instead')
const ProtoPattern$json = const {
  '1': 'ProtoPattern',
  '2': const [
    const {'1': 'PatternId', '3': 1, '4': 1, '5': 5, '10': 'PatternId'},
    const {'1': 'PatternName', '3': 2, '4': 1, '5': 9, '10': 'PatternName'},
    const {'1': 'StepCount', '3': 3, '4': 1, '5': 5, '10': 'StepCount'},
    const {'1': 'TotalTime', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'TotalTime'},
    const {'1': 'AirPump', '3': 5, '4': 1, '5': 11, '6': '.Oven.ProtoAirpump', '10': 'AirPump'},
    const {'1': 'PatternDetail', '3': 6, '4': 3, '5': 11, '6': '.Oven.ProtoPatternDetail', '10': 'PatternDetail'},
    const {'1': 'UseAfb', '3': 7, '4': 1, '5': 8, '10': 'UseAfb'},
    const {'1': 'CreateDate', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'CreateDate'},
    const {'1': 'ModifyDate', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'ModifyDate'},
  ],
};

/// Descriptor for `ProtoPattern`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPatternDescriptor = $convert.base64Decode('CgxQcm90b1BhdHRlcm4SHAoJUGF0dGVybklkGAEgASgFUglQYXR0ZXJuSWQSIAoLUGF0dGVybk5hbWUYAiABKAlSC1BhdHRlcm5OYW1lEhwKCVN0ZXBDb3VudBgDIAEoBVIJU3RlcENvdW50EjcKCVRvdGFsVGltZRgEIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIJVG90YWxUaW1lEiwKB0FpclB1bXAYBSABKAsyEi5PdmVuLlByb3RvQWlycHVtcFIHQWlyUHVtcBI+Cg1QYXR0ZXJuRGV0YWlsGAYgAygLMhguT3Zlbi5Qcm90b1BhdHRlcm5EZXRhaWxSDVBhdHRlcm5EZXRhaWwSFgoGVXNlQWZiGAcgASgIUgZVc2VBZmISOgoKQ3JlYXRlRGF0ZRgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCkNyZWF0ZURhdGUSOgoKTW9kaWZ5RGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCk1vZGlmeURhdGU=');
@$core.Deprecated('Use protoAirpumpDescriptor instead')
const ProtoAirpump$json = const {
  '1': 'ProtoAirpump',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 5, '10': 'Id'},
    const {'1': 'StartTemp', '3': 2, '4': 1, '5': 5, '10': 'StartTemp'},
    const {'1': 'EndTemp', '3': 3, '4': 1, '5': 5, '10': 'EndTemp'},
    const {'1': 'DelayMinuteDuration', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'DelayMinuteDuration'},
    const {'1': 'UseAirpump', '3': 5, '4': 1, '5': 8, '10': 'UseAirpump'},
  ],
};

/// Descriptor for `ProtoAirpump`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoAirpumpDescriptor = $convert.base64Decode('CgxQcm90b0FpcnB1bXASDgoCSWQYASABKAVSAklkEhwKCVN0YXJ0VGVtcBgCIAEoBVIJU3RhcnRUZW1wEhgKB0VuZFRlbXAYAyABKAVSB0VuZFRlbXASSwoTRGVsYXlNaW51dGVEdXJhdGlvbhgEIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblITRGVsYXlNaW51dGVEdXJhdGlvbhIeCgpVc2VBaXJwdW1wGAUgASgIUgpVc2VBaXJwdW1w');
@$core.Deprecated('Use protoPatternDetailDescriptor instead')
const ProtoPatternDetail$json = const {
  '1': 'ProtoPatternDetail',
  '2': const [
    const {'1': 'DetailId', '3': 1, '4': 1, '5': 5, '10': 'DetailId'},
    const {'1': 'PatternId', '3': 2, '4': 1, '5': 5, '10': 'PatternId'},
    const {'1': 'Step', '3': 3, '4': 1, '5': 5, '10': 'Step'},
    const {'1': 'Temp', '3': 4, '4': 1, '5': 5, '10': 'Temp'},
    const {'1': 'StepDuration', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'StepDuration'},
  ],
};

/// Descriptor for `ProtoPatternDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPatternDetailDescriptor = $convert.base64Decode('ChJQcm90b1BhdHRlcm5EZXRhaWwSGgoIRGV0YWlsSWQYASABKAVSCERldGFpbElkEhwKCVBhdHRlcm5JZBgCIAEoBVIJUGF0dGVybklkEhIKBFN0ZXAYAyABKAVSBFN0ZXASEgoEVGVtcBgEIAEoBVIEVGVtcBI9CgxTdGVwRHVyYXRpb24YBSABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SDFN0ZXBEdXJhdGlvbg==');

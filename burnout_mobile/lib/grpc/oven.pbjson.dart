///
//  Generated code. Do not modify.
//  source: oven.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package, constant_identifier_names

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
@$core.Deprecated('Use protoOvenSettingDescriptor instead')
const ProtoOvenSetting$json = const {
  '1': 'ProtoOvenSetting',
  '2': const [
    const {'1': 'SettingId', '3': 1, '4': 1, '5': 5, '10': 'SettingId'},
    const {'1': 'AfbStartTemp', '3': 2, '4': 1, '5': 5, '10': 'AfbStartTemp'},
    const {'1': 'AfbEndTemp', '3': 3, '4': 1, '5': 5, '10': 'AfbEndTemp'},
    const {'1': 'AfbDelay', '3': 4, '4': 1, '5': 5, '10': 'AfbDelay'},
    const {'1': 'TubeStartTemp', '3': 5, '4': 1, '5': 5, '10': 'TubeStartTemp'},
    const {'1': 'FloorStartTemp', '3': 6, '4': 1, '5': 5, '10': 'FloorStartTemp'},
    const {'1': 'AlarmOven', '3': 7, '4': 1, '5': 5, '10': 'AlarmOven'},
    const {'1': 'AlarmAfb', '3': 8, '4': 1, '5': 5, '10': 'AlarmAfb'},
  ],
};

/// Descriptor for `ProtoOvenSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOvenSettingDescriptor = $convert.base64Decode('ChBQcm90b092ZW5TZXR0aW5nEhwKCVNldHRpbmdJZBgBIAEoBVIJU2V0dGluZ0lkEiIKDEFmYlN0YXJ0VGVtcBgCIAEoBVIMQWZiU3RhcnRUZW1wEh4KCkFmYkVuZFRlbXAYAyABKAVSCkFmYkVuZFRlbXASGgoIQWZiRGVsYXkYBCABKAVSCEFmYkRlbGF5EiQKDVR1YmVTdGFydFRlbXAYBSABKAVSDVR1YmVTdGFydFRlbXASJgoORmxvb3JTdGFydFRlbXAYBiABKAVSDkZsb29yU3RhcnRUZW1wEhwKCUFsYXJtT3ZlbhgHIAEoBVIJQWxhcm1PdmVuEhoKCEFsYXJtQWZiGAggASgFUghBbGFybUFmYg==');
@$core.Deprecated('Use protoOvenResponseDescriptor instead')
const ProtoOvenResponse$json = const {
  '1': 'ProtoOvenResponse',
  '2': const [
    const {'1': 'Temp', '3': 1, '4': 1, '5': 11, '6': '.Oven.Temp', '10': 'Temp'},
    const {'1': 'Coil', '3': 2, '4': 1, '5': 11, '6': '.Oven.Coil', '10': 'Coil'},
    const {'1': 'Status', '3': 3, '4': 1, '5': 11, '6': '.Oven.mcStatus', '10': 'Status'},
  ],
};

/// Descriptor for `ProtoOvenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoOvenResponseDescriptor = $convert.base64Decode('ChFQcm90b092ZW5SZXNwb25zZRIeCgRUZW1wGAEgASgLMgouT3Zlbi5UZW1wUgRUZW1wEh4KBENvaWwYAiABKAsyCi5PdmVuLkNvaWxSBENvaWwSJgoGU3RhdHVzGAMgASgLMg4uT3Zlbi5tY1N0YXR1c1IGU3RhdHVz');
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
@$core.Deprecated('Use mcStatusDescriptor instead')
const mcStatus$json = const {
  '1': 'mcStatus',
  '2': const [
    const {'1': 'Door', '3': 1, '4': 1, '5': 8, '10': 'Door'},
    const {'1': 'Operation', '3': 2, '4': 1, '5': 8, '10': 'Operation'},
    const {'1': 'PatternId', '3': 3, '4': 1, '5': 5, '10': 'PatternId'},
    const {'1': 'TotalStep', '3': 4, '4': 1, '5': 5, '10': 'TotalStep'},
    const {'1': 'CurrentStep', '3': 5, '4': 1, '5': 5, '10': 'CurrentStep'},
    const {'1': 'PatternStatus', '3': 6, '4': 1, '5': 14, '6': '.Oven.PatternStatus', '10': 'PatternStatus'},
    const {'1': 'RemainHours', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'RemainHours'},
    const {'1': 'RemainMins', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'RemainMins'},
  ],
};

/// Descriptor for `mcStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mcStatusDescriptor = $convert.base64Decode('CghtY1N0YXR1cxISCgREb29yGAEgASgIUgREb29yEhwKCU9wZXJhdGlvbhgCIAEoCFIJT3BlcmF0aW9uEhwKCVBhdHRlcm5JZBgDIAEoBVIJUGF0dGVybklkEhwKCVRvdGFsU3RlcBgEIAEoBVIJVG90YWxTdGVwEiAKC0N1cnJlbnRTdGVwGAUgASgFUgtDdXJyZW50U3RlcBI5Cg1QYXR0ZXJuU3RhdHVzGAYgASgOMhMuT3Zlbi5QYXR0ZXJuU3RhdHVzUg1QYXR0ZXJuU3RhdHVzEjsKC1JlbWFpbkhvdXJzGAcgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUgtSZW1haW5Ib3VycxI5CgpSZW1haW5NaW5zGAggASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUgpSZW1haW5NaW5z');
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
    const {'1': 'CreateDate', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'CreateDate'},
    const {'1': 'ModifyDate', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'ModifyDate'},
  ],
};

/// Descriptor for `ProtoPattern`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPatternDescriptor = $convert.base64Decode('CgxQcm90b1BhdHRlcm4SHAoJUGF0dGVybklkGAEgASgFUglQYXR0ZXJuSWQSIAoLUGF0dGVybk5hbWUYAiABKAlSC1BhdHRlcm5OYW1lEhwKCVN0ZXBDb3VudBgDIAEoBVIJU3RlcENvdW50EjcKCVRvdGFsVGltZRgEIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIJVG90YWxUaW1lEiwKB0FpclB1bXAYBSABKAsyEi5PdmVuLlByb3RvQWlycHVtcFIHQWlyUHVtcBI+Cg1QYXR0ZXJuRGV0YWlsGAYgAygLMhguT3Zlbi5Qcm90b1BhdHRlcm5EZXRhaWxSDVBhdHRlcm5EZXRhaWwSOgoKQ3JlYXRlRGF0ZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCkNyZWF0ZURhdGUSOgoKTW9kaWZ5RGF0ZRgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCk1vZGlmeURhdGU=');
@$core.Deprecated('Use protoAirpumpDescriptor instead')
const ProtoAirpump$json = const {
  '1': 'ProtoAirpump',
  '2': const [
    const {'1': 'Id', '3': 1, '4': 1, '5': 5, '10': 'Id'},
    const {'1': 'StartTemp', '3': 3, '4': 1, '5': 5, '10': 'StartTemp'},
    const {'1': 'EndTemp', '3': 4, '4': 1, '5': 5, '10': 'EndTemp'},
    const {'1': 'DelayMinuteDuration', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Duration', '10': 'DelayMinuteDuration'},
  ],
};

/// Descriptor for `ProtoAirpump`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoAirpumpDescriptor = $convert.base64Decode('CgxQcm90b0FpcnB1bXASDgoCSWQYASABKAVSAklkEhwKCVN0YXJ0VGVtcBgDIAEoBVIJU3RhcnRUZW1wEhgKB0VuZFRlbXAYBCABKAVSB0VuZFRlbXASSwoTRGVsYXlNaW51dGVEdXJhdGlvbhgFIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblITRGVsYXlNaW51dGVEdXJhdGlvbg==');
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
@$core.Deprecated('Use protoPatternListDescriptor instead')
const ProtoPatternList$json = const {
  '1': 'ProtoPatternList',
  '2': const [
    const {'1': 'Pattern', '3': 1, '4': 3, '5': 11, '6': '.Oven.ProtoPattern', '10': 'Pattern'},
  ],
};

/// Descriptor for `ProtoPatternList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoPatternListDescriptor = $convert.base64Decode('ChBQcm90b1BhdHRlcm5MaXN0EiwKB1BhdHRlcm4YASADKAsyEi5PdmVuLlByb3RvUGF0dGVyblIHUGF0dGVybg==');

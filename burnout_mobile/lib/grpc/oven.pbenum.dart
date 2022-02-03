///
//  Generated code. Do not modify.
//  source: oven.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields, constant_identifier_names

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PatternStatus extends $pb.ProtobufEnum {
  static const PatternStatus Standby = PatternStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Standby');
  static const PatternStatus Up = PatternStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Up');
  static const PatternStatus Down = PatternStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Down');
  static const PatternStatus Stable = PatternStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Stable');
  static const PatternStatus End = PatternStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'End');

  static const $core.List<PatternStatus> values = <PatternStatus> [
    Standby,
    Up,
    Down,
    Stable,
    End,
  ];

  static final $core.Map<$core.int, PatternStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PatternStatus? valueOf($core.int value) => _byValue[value];

  const PatternStatus._($core.int v, $core.String n) : super(v, n);
}


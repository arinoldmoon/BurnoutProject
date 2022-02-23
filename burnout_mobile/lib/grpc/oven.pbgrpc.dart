///
//  Generated code. Do not modify.
//  source: oven.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/empty.pb.dart' as $0;
import 'google/protobuf/wrappers.pb.dart' as $1;
import 'oven.pb.dart' as $2;
export 'oven.pb.dart';

class OvenProtoClient extends $grpc.Client {
  static final _$grpcConnect = $grpc.ClientMethod<$0.Empty, $1.BoolValue>(
      '/Oven.OvenProto/GrpcConnect',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$pLCConnect = $grpc.ClientMethod<$0.Empty, $1.BoolValue>(
      '/Oven.OvenProto/PLCConnect',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$getOvenInfo = $grpc.ClientMethod<$0.Empty, $2.ProtoOvenInfo>(
      '/Oven.OvenProto/GetOvenInfo',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ProtoOvenInfo.fromBuffer(value));
  static final _$updateMachineInfo =
      $grpc.ClientMethod<$2.ProtoOvenInfo, $1.BoolValue>(
          '/Oven.OvenProto/UpdateMachineInfo',
          ($2.ProtoOvenInfo value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$getOvenSetting =
      $grpc.ClientMethod<$0.Empty, $2.ProtoOvenSetting>(
          '/Oven.OvenProto/GetOvenSetting',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ProtoOvenSetting.fromBuffer(value));
  static final _$updateOvenSetting =
      $grpc.ClientMethod<$2.ProtoOvenSetting, $1.BoolValue>(
          '/Oven.OvenProto/UpdateOvenSetting',
          ($2.ProtoOvenSetting value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$monitorDevice =
      $grpc.ClientMethod<$0.Empty, $2.ProtoOvenResponse>(
          '/Oven.OvenProto/MonitorDevice',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ProtoOvenResponse.fromBuffer(value));

  OvenProtoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.BoolValue> grpcConnect($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$grpcConnect, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> pLCConnect($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pLCConnect, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProtoOvenInfo> getOvenInfo($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOvenInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> updateMachineInfo($2.ProtoOvenInfo request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMachineInfo, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProtoOvenSetting> getOvenSetting($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOvenSetting, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> updateOvenSetting(
      $2.ProtoOvenSetting request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateOvenSetting, request, options: options);
  }

  $grpc.ResponseStream<$2.ProtoOvenResponse> monitorDevice($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$monitorDevice, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class OvenProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.OvenProto';

  OvenProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.BoolValue>(
        'GrpcConnect',
        grpcConnect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.BoolValue>(
        'PLCConnect',
        pLCConnect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $2.ProtoOvenInfo>(
        'GetOvenInfo',
        getOvenInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($2.ProtoOvenInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ProtoOvenInfo, $1.BoolValue>(
        'UpdateMachineInfo',
        updateMachineInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ProtoOvenInfo.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $2.ProtoOvenSetting>(
        'GetOvenSetting',
        getOvenSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($2.ProtoOvenSetting value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ProtoOvenSetting, $1.BoolValue>(
        'UpdateOvenSetting',
        updateOvenSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ProtoOvenSetting.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $2.ProtoOvenResponse>(
        'MonitorDevice',
        monitorDevice_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($2.ProtoOvenResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.BoolValue> grpcConnect_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return grpcConnect(call, await request);
  }

  $async.Future<$1.BoolValue> pLCConnect_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return pLCConnect(call, await request);
  }

  $async.Future<$2.ProtoOvenInfo> getOvenInfo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getOvenInfo(call, await request);
  }

  $async.Future<$1.BoolValue> updateMachineInfo_Pre(
      $grpc.ServiceCall call, $async.Future<$2.ProtoOvenInfo> request) async {
    return updateMachineInfo(call, await request);
  }

  $async.Future<$2.ProtoOvenSetting> getOvenSetting_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getOvenSetting(call, await request);
  }

  $async.Future<$1.BoolValue> updateOvenSetting_Pre($grpc.ServiceCall call,
      $async.Future<$2.ProtoOvenSetting> request) async {
    return updateOvenSetting(call, await request);
  }

  $async.Stream<$2.ProtoOvenResponse> monitorDevice_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* monitorDevice(call, await request);
  }

  $async.Future<$1.BoolValue> grpcConnect(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.BoolValue> pLCConnect(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$2.ProtoOvenInfo> getOvenInfo(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.BoolValue> updateMachineInfo(
      $grpc.ServiceCall call, $2.ProtoOvenInfo request);
  $async.Future<$2.ProtoOvenSetting> getOvenSetting(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.BoolValue> updateOvenSetting(
      $grpc.ServiceCall call, $2.ProtoOvenSetting request);
  $async.Stream<$2.ProtoOvenResponse> monitorDevice(
      $grpc.ServiceCall call, $0.Empty request);
}

class PatternProtoClient extends $grpc.Client {
  static final _$getPatternList =
      $grpc.ClientMethod<$0.Empty, $2.ProtoPatternList>(
          '/Oven.PatternProto/GetPatternList',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ProtoPatternList.fromBuffer(value));
  static final _$getPattern =
      $grpc.ClientMethod<$1.Int32Value, $2.ProtoPattern>(
          '/Oven.PatternProto/GetPattern',
          ($1.Int32Value value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.ProtoPattern.fromBuffer(value));
  static final _$createPattern =
      $grpc.ClientMethod<$2.ProtoPattern, $1.BoolValue>(
          '/Oven.PatternProto/CreatePattern',
          ($2.ProtoPattern value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$updatePattern =
      $grpc.ClientMethod<$2.ProtoPattern, $1.BoolValue>(
          '/Oven.PatternProto/UpdatePattern',
          ($2.ProtoPattern value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$deletePattern =
      $grpc.ClientMethod<$1.Int32Value, $1.BoolValue>(
          '/Oven.PatternProto/DeletePattern',
          ($1.Int32Value value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));

  PatternProtoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.ProtoPatternList> getPatternList($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPatternList, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProtoPattern> getPattern($1.Int32Value request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPattern, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> createPattern($2.ProtoPattern request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPattern, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> updatePattern($2.ProtoPattern request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePattern, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> deletePattern($1.Int32Value request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePattern, request, options: options);
  }
}

abstract class PatternProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.PatternProto';

  PatternProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $2.ProtoPatternList>(
        'GetPatternList',
        getPatternList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($2.ProtoPatternList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Int32Value, $2.ProtoPattern>(
        'GetPattern',
        getPattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Int32Value.fromBuffer(value),
        ($2.ProtoPattern value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ProtoPattern, $1.BoolValue>(
        'CreatePattern',
        createPattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ProtoPattern.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ProtoPattern, $1.BoolValue>(
        'UpdatePattern',
        updatePattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ProtoPattern.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Int32Value, $1.BoolValue>(
        'DeletePattern',
        deletePattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Int32Value.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$2.ProtoPatternList> getPatternList_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getPatternList(call, await request);
  }

  $async.Future<$2.ProtoPattern> getPattern_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Int32Value> request) async {
    return getPattern(call, await request);
  }

  $async.Future<$1.BoolValue> createPattern_Pre(
      $grpc.ServiceCall call, $async.Future<$2.ProtoPattern> request) async {
    return createPattern(call, await request);
  }

  $async.Future<$1.BoolValue> updatePattern_Pre(
      $grpc.ServiceCall call, $async.Future<$2.ProtoPattern> request) async {
    return updatePattern(call, await request);
  }

  $async.Future<$1.BoolValue> deletePattern_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Int32Value> request) async {
    return deletePattern(call, await request);
  }

  $async.Future<$2.ProtoPatternList> getPatternList(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$2.ProtoPattern> getPattern(
      $grpc.ServiceCall call, $1.Int32Value request);
  $async.Future<$1.BoolValue> createPattern(
      $grpc.ServiceCall call, $2.ProtoPattern request);
  $async.Future<$1.BoolValue> updatePattern(
      $grpc.ServiceCall call, $2.ProtoPattern request);
  $async.Future<$1.BoolValue> deletePattern(
      $grpc.ServiceCall call, $1.Int32Value request);
}

class OperationProtoClient extends $grpc.Client {
  static final _$startOperation =
      $grpc.ClientMethod<$2.ProtoPattern, $1.BoolValue>(
          '/Oven.OperationProto/StartOperation',
          ($2.ProtoPattern value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$stopOperation = $grpc.ClientMethod<$0.Empty, $1.BoolValue>(
      '/Oven.OperationProto/StopOperation',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BoolValue.fromBuffer(value));
  static final _$currentPattern = $grpc.ClientMethod<$0.Empty, $2.ProtoPattern>(
      '/Oven.OperationProto/CurrentPattern',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ProtoPattern.fromBuffer(value));

  OperationProtoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.BoolValue> startOperation($2.ProtoPattern request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startOperation, request, options: options);
  }

  $grpc.ResponseFuture<$1.BoolValue> stopOperation($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopOperation, request, options: options);
  }

  $grpc.ResponseFuture<$2.ProtoPattern> currentPattern($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$currentPattern, request, options: options);
  }
}

abstract class OperationProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.OperationProto';

  OperationProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.ProtoPattern, $1.BoolValue>(
        'StartOperation',
        startOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ProtoPattern.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.BoolValue>(
        'StopOperation',
        stopOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $2.ProtoPattern>(
        'CurrentPattern',
        currentPattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($2.ProtoPattern value) => value.writeToBuffer()));
  }

  $async.Future<$1.BoolValue> startOperation_Pre(
      $grpc.ServiceCall call, $async.Future<$2.ProtoPattern> request) async {
    return startOperation(call, await request);
  }

  $async.Future<$1.BoolValue> stopOperation_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return stopOperation(call, await request);
  }

  $async.Future<$2.ProtoPattern> currentPattern_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return currentPattern(call, await request);
  }

  $async.Future<$1.BoolValue> startOperation(
      $grpc.ServiceCall call, $2.ProtoPattern request);
  $async.Future<$1.BoolValue> stopOperation(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$2.ProtoPattern> currentPattern(
      $grpc.ServiceCall call, $0.Empty request);
}

class NotificationProtoClient extends $grpc.Client {
  static final _$notification = $grpc.ClientMethod<$0.Empty, $0.Empty>(
      '/Oven.NotificationProto/Notification',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  NotificationProtoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Empty> notification($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$notification, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class NotificationProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.NotificationProto';

  NotificationProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Empty>(
        'Notification',
        notification_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Empty> notification_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* notification(call, await request);
  }

  $async.Stream<$0.Empty> notification(
      $grpc.ServiceCall call, $0.Empty request);
}

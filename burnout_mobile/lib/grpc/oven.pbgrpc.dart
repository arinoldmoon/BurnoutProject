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
import 'oven.pb.dart' as $1;
import 'google/protobuf/wrappers.pb.dart' as $2;
export 'oven.pb.dart';

class OvenProtoServiceClient extends $grpc.Client {
  static final _$deviceConnect =
      $grpc.ClientMethod<$0.Empty, $1.ProtoServiceConnection>(
          '/Oven.OvenProtoService/DeviceConnect',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProtoServiceConnection.fromBuffer(value));
  static final _$monitorDevice =
      $grpc.ClientMethod<$0.Empty, $1.ProtoOvenResponse>(
          '/Oven.OvenProtoService/MonitorDevice',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProtoOvenResponse.fromBuffer(value));
  static final _$getOvenSetting =
      $grpc.ClientMethod<$0.Empty, $1.ProtoOvenSetting>(
          '/Oven.OvenProtoService/GetOvenSetting',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProtoOvenSetting.fromBuffer(value));
  static final _$updateOvenSetting =
      $grpc.ClientMethod<$1.ProtoOvenSetting, $2.BoolValue>(
          '/Oven.OvenProtoService/UpdateOvenSetting',
          ($1.ProtoOvenSetting value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));

  OvenProtoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.ProtoServiceConnection> deviceConnect(
      $0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deviceConnect, request, options: options);
  }

  $grpc.ResponseStream<$1.ProtoOvenResponse> monitorDevice($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$monitorDevice, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$1.ProtoOvenSetting> getOvenSetting($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOvenSetting, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> updateOvenSetting(
      $1.ProtoOvenSetting request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateOvenSetting, request, options: options);
  }
}

abstract class OvenProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.OvenProtoService';

  OvenProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ProtoServiceConnection>(
        'DeviceConnect',
        deviceConnect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ProtoServiceConnection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ProtoOvenResponse>(
        'MonitorDevice',
        monitorDevice_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ProtoOvenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ProtoOvenSetting>(
        'GetOvenSetting',
        getOvenSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ProtoOvenSetting value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProtoOvenSetting, $2.BoolValue>(
        'UpdateOvenSetting',
        updateOvenSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProtoOvenSetting.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$1.ProtoServiceConnection> deviceConnect_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return deviceConnect(call, await request);
  }

  $async.Stream<$1.ProtoOvenResponse> monitorDevice_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* monitorDevice(call, await request);
  }

  $async.Future<$1.ProtoOvenSetting> getOvenSetting_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getOvenSetting(call, await request);
  }

  $async.Future<$2.BoolValue> updateOvenSetting_Pre($grpc.ServiceCall call,
      $async.Future<$1.ProtoOvenSetting> request) async {
    return updateOvenSetting(call, await request);
  }

  $async.Future<$1.ProtoServiceConnection> deviceConnect(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$1.ProtoOvenResponse> monitorDevice(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.ProtoOvenSetting> getOvenSetting(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$2.BoolValue> updateOvenSetting(
      $grpc.ServiceCall call, $1.ProtoOvenSetting request);
}

class PatternProtoServiceClient extends $grpc.Client {
  static final _$getPatternList =
      $grpc.ClientMethod<$0.Empty, $1.ProtoPatternList>(
          '/Oven.PatternProtoService/GetPatternList',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProtoPatternList.fromBuffer(value));
  static final _$getPattern =
      $grpc.ClientMethod<$2.Int32Value, $1.ProtoPattern>(
          '/Oven.PatternProtoService/GetPattern',
          ($2.Int32Value value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.ProtoPattern.fromBuffer(value));
  static final _$createPattern =
      $grpc.ClientMethod<$1.ProtoPattern, $2.BoolValue>(
          '/Oven.PatternProtoService/CreatePattern',
          ($1.ProtoPattern value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$updatePattern =
      $grpc.ClientMethod<$1.ProtoPattern, $2.BoolValue>(
          '/Oven.PatternProtoService/UpdatePattern',
          ($1.ProtoPattern value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$deletePattern =
      $grpc.ClientMethod<$2.Int32Value, $2.BoolValue>(
          '/Oven.PatternProtoService/DeletePattern',
          ($2.Int32Value value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));

  PatternProtoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.ProtoPatternList> getPatternList($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPatternList, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProtoPattern> getPattern($2.Int32Value request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPattern, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> createPattern($1.ProtoPattern request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPattern, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> updatePattern($1.ProtoPattern request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePattern, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> deletePattern($2.Int32Value request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePattern, request, options: options);
  }
}

abstract class PatternProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.PatternProtoService';

  PatternProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ProtoPatternList>(
        'GetPatternList',
        getPatternList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ProtoPatternList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Int32Value, $1.ProtoPattern>(
        'GetPattern',
        getPattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Int32Value.fromBuffer(value),
        ($1.ProtoPattern value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProtoPattern, $2.BoolValue>(
        'CreatePattern',
        createPattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProtoPattern.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProtoPattern, $2.BoolValue>(
        'UpdatePattern',
        updatePattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProtoPattern.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Int32Value, $2.BoolValue>(
        'DeletePattern',
        deletePattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Int32Value.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$1.ProtoPatternList> getPatternList_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getPatternList(call, await request);
  }

  $async.Future<$1.ProtoPattern> getPattern_Pre(
      $grpc.ServiceCall call, $async.Future<$2.Int32Value> request) async {
    return getPattern(call, await request);
  }

  $async.Future<$2.BoolValue> createPattern_Pre(
      $grpc.ServiceCall call, $async.Future<$1.ProtoPattern> request) async {
    return createPattern(call, await request);
  }

  $async.Future<$2.BoolValue> updatePattern_Pre(
      $grpc.ServiceCall call, $async.Future<$1.ProtoPattern> request) async {
    return updatePattern(call, await request);
  }

  $async.Future<$2.BoolValue> deletePattern_Pre(
      $grpc.ServiceCall call, $async.Future<$2.Int32Value> request) async {
    return deletePattern(call, await request);
  }

  $async.Future<$1.ProtoPatternList> getPatternList(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.ProtoPattern> getPattern(
      $grpc.ServiceCall call, $2.Int32Value request);
  $async.Future<$2.BoolValue> createPattern(
      $grpc.ServiceCall call, $1.ProtoPattern request);
  $async.Future<$2.BoolValue> updatePattern(
      $grpc.ServiceCall call, $1.ProtoPattern request);
  $async.Future<$2.BoolValue> deletePattern(
      $grpc.ServiceCall call, $2.Int32Value request);
}

class OperationProtoServiceClient extends $grpc.Client {
  static final _$getOperationLogWithID =
      $grpc.ClientMethod<$2.Int32Value, $1.ActualLogList>(
          '/Oven.OperationProtoService/GetOperationLogWithID',
          ($2.Int32Value value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.ActualLogList.fromBuffer(value));
  static final _$getOperationLogWithFilter =
      $grpc.ClientMethod<$1.OperationLogWithFilter, $1.ProtoOperationLogInfo>(
          '/Oven.OperationProtoService/GetOperationLogWithFilter',
          ($1.OperationLogWithFilter value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProtoOperationLogInfo.fromBuffer(value));
  static final _$startOperation =
      $grpc.ClientMethod<$1.ProtoPattern, $2.BoolValue>(
          '/Oven.OperationProtoService/StartOperation',
          ($1.ProtoPattern value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$stopOperation = $grpc.ClientMethod<$0.Empty, $2.BoolValue>(
      '/Oven.OperationProtoService/StopOperation',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$currentPattern = $grpc.ClientMethod<$0.Empty, $1.ProtoPattern>(
      '/Oven.OperationProtoService/CurrentPattern',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ProtoPattern.fromBuffer(value));

  OperationProtoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.ActualLogList> getOperationLogWithID(
      $2.Int32Value request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOperationLogWithID, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProtoOperationLogInfo> getOperationLogWithFilter(
      $1.OperationLogWithFilter request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOperationLogWithFilter, request,
        options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> startOperation($1.ProtoPattern request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startOperation, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> stopOperation($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopOperation, request, options: options);
  }

  $grpc.ResponseFuture<$1.ProtoPattern> currentPattern($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$currentPattern, request, options: options);
  }
}

abstract class OperationProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'Oven.OperationProtoService';

  OperationProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.Int32Value, $1.ActualLogList>(
        'GetOperationLogWithID',
        getOperationLogWithID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Int32Value.fromBuffer(value),
        ($1.ActualLogList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.OperationLogWithFilter,
            $1.ProtoOperationLogInfo>(
        'GetOperationLogWithFilter',
        getOperationLogWithFilter_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.OperationLogWithFilter.fromBuffer(value),
        ($1.ProtoOperationLogInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ProtoPattern, $2.BoolValue>(
        'StartOperation',
        startOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ProtoPattern.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $2.BoolValue>(
        'StopOperation',
        stopOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ProtoPattern>(
        'CurrentPattern',
        currentPattern_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ProtoPattern value) => value.writeToBuffer()));
  }

  $async.Future<$1.ActualLogList> getOperationLogWithID_Pre(
      $grpc.ServiceCall call, $async.Future<$2.Int32Value> request) async {
    return getOperationLogWithID(call, await request);
  }

  $async.Future<$1.ProtoOperationLogInfo> getOperationLogWithFilter_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.OperationLogWithFilter> request) async {
    return getOperationLogWithFilter(call, await request);
  }

  $async.Future<$2.BoolValue> startOperation_Pre(
      $grpc.ServiceCall call, $async.Future<$1.ProtoPattern> request) async {
    return startOperation(call, await request);
  }

  $async.Future<$2.BoolValue> stopOperation_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return stopOperation(call, await request);
  }

  $async.Future<$1.ProtoPattern> currentPattern_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return currentPattern(call, await request);
  }

  $async.Future<$1.ActualLogList> getOperationLogWithID(
      $grpc.ServiceCall call, $2.Int32Value request);
  $async.Future<$1.ProtoOperationLogInfo> getOperationLogWithFilter(
      $grpc.ServiceCall call, $1.OperationLogWithFilter request);
  $async.Future<$2.BoolValue> startOperation(
      $grpc.ServiceCall call, $1.ProtoPattern request);
  $async.Future<$2.BoolValue> stopOperation(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.ProtoPattern> currentPattern(
      $grpc.ServiceCall call, $0.Empty request);
}

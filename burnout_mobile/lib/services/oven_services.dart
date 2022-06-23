import 'package:burnout_mobile/grpc/google/protobuf/empty.pb.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:burnout_mobile/services/clinet_chanel.dart';
import 'package:grpc/grpc.dart';

class OvenServices {
  late ProtoServiceConnection ovenInfo;
  final OvenProtoServiceClient ovenStub =
      OvenProtoServiceClient(ClinetChanel.channel);
  final PatternProtoServiceClient patternStub =
      PatternProtoServiceClient(ClinetChanel.channel);
  late ResponseStream<ProtoOvenResponse> monitorDeviceResponse;

  Future<ResponseStream<ProtoOvenResponse>> fetchMonitorDevice() async {
    monitorDeviceResponse = ovenStub.monitorDevice(Empty());
    return monitorDeviceResponse;
  }
}

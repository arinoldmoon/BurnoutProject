import 'package:burnout_mobile/grpc/google/protobuf/empty.pb.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:burnout_mobile/services/grpc_client.dart';
import 'package:grpc/grpc.dart';

class OvenServices {
  late ProtoServiceConnection ovenInfo;
  final PatternProtoServiceClient patternStub =
      PatternProtoServiceClient(GrpcClient().client);
  late ResponseStream<ProtoOvenResponse> monitorDeviceResponse;

  static Future<ResponseStream<ProtoOvenResponse>> fetchMonitorDevice() async {
    OvenProtoServiceClient ovenStub =
        OvenProtoServiceClient(GrpcClient().client);
    return ovenStub.monitorDevice(Empty());
  }
}

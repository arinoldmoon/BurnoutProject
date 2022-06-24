import 'package:grpc/grpc.dart';

class GrpcClient {
  late ClientChannel client;
  static final GrpcClient _singleton = GrpcClient._internal();

  factory GrpcClient() => _singleton;

  GrpcClient._internal() {
    client = ClientChannel(
      "localhost",
        port: 5000,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(minutes: 3),
        ));
  }
}

import 'package:grpc/grpc.dart';

class GrpcClient {
  late ClientChannel client;
  static final GrpcClient _singleton = GrpcClient._internal();

  factory GrpcClient() => _singleton;

  GrpcClient._internal() {
    client = ClientChannel(
        "192.168.1.124", // Your IP here, localhost might not work.
        port: 3000,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(minutes: 3),
        ));
  }
}

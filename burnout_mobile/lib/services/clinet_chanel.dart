import 'package:grpc/grpc.dart';

class ClinetChanel {
  static final channel = ClientChannel(
    '192.168.1.124', // Use your IP address where the server is running
    port: 5000,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
}

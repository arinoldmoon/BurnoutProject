import 'package:burnout_mobile/grpc/google/protobuf/empty.pb.dart';
import 'package:burnout_mobile/grpc/google/protobuf/wrappers.pb.dart';
import 'package:burnout_mobile/grpc/oven.pb.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static late BoolValue isConnected = BoolValue();
  static late ProtoOvenInfo info = ProtoOvenInfo();

  static final channel = ClientChannel(
    'localhost',
    port: 5000,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  static final OvenProtoClient ovenStub = OvenProtoClient(channel);

  Stream<ProtoOvenResponse> monitorDevice() async* {
    await for (ProtoOvenResponse monitor in ovenStub.monitorDevice(Empty())) {
      yield monitor;
    }
  }

  Future connect() async {
    debugPrint('Call GrpcConnect');
    if ((await ovenStub.grpcConnect(Empty())).value == true) {
      debugPrint('Call GetOvenInfo');
      ProtoOvenInfo ovenResponse = await ovenStub.getOvenInfo(Empty());

      setState(() {
        isConnected.value = true;
        info = ovenResponse;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Grpc Connect : ${isConnected.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'MachineName : ${info.machineName}',
              style: Theme.of(context).textTheme.headline6,
            ),
            StreamBuilder<ProtoOvenResponse>(
              stream: monitorDevice(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        'TempOven : ${snapshot.data!.temp.tempOven}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          const TextSpan(text: 'Door'),
                          WidgetSpan(
                              child: Icon(
                            Icons.circle,
                            color: snapshot.data!.status.door
                                ? Colors.green
                                : Colors.red,
                          )),
                        ], style: Theme.of(context).textTheme.headline6),
                      ),
                    ],
                  );
                }
                return Text(
                  'TempOven : 0',
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

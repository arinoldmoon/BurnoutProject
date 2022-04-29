import 'package:burnout_mobile/burnout.dart';
import 'package:burnout_mobile/grpc/google/protobuf/empty.pb.dart';
import 'package:burnout_mobile/grpc/google/protobuf/wrappers.pb.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:burnout_mobile/test_grpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(const MaterialApp(home: Burnout()));
}

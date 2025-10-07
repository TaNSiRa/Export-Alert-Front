import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../data/global.dart';
import '../../page/P01INPUTDATA/P01INPUTDATAMAIN.dart';

late IO.Socket socket;
// late P01INPUTDATAGETDATA_Bloc dashboardBloc;

void initSocketConnection() {
  socket = IO.io(ToServer, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  socket.connect();

  // เมื่อเชื่อมต่อสำเร็จ
  socket.on('connect', (_) {
    print('Connected to socket.io server: ${socket.id}');
  });

  // รับข้อมูลเพื่อรีเฟรช UI
  socket.on('Close popup', (data) {
    print('Close popup: $data');
    // Navigator.pop(P01INPUTDATAMAINcontext);
    Navigator.of(P01INPUTDATAcontext).popUntil((route) => route.isFirst);
    // P01INPUTDATAMAINcontext.read<P01INPUTDATAGETDATA_Bloc>().add(P01INPUTDATAGETDATA_GET());
    // dashboardBloc.add(P01INPUTDATAGETDATA_GET());
  });

  // disconnect
  socket.on('disconnect', (_) {
    print('Disconnected from socket.io');
  });
}

void sendDataToServer(dynamic data) {
  print('Send data to server');
  socket.emit('Close-popup', data);
}

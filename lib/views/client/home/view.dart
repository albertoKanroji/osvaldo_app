import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osvaldo_app/services/bluetooth/controller.dart';
import 'package:osvaldo_app/services/bluetooth/listen.dart';
import 'package:osvaldo_app/views/client/home/controller.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomeClientPage extends StatelessWidget {
  final BluetoothControllerListen bluetoothController =
      Get.put(BluetoothControllerListen());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Cliente'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                bluetoothController.scanDevices();
              },
              child: Text('Escanear dispositivos'),
            ),
            Expanded(
              child: Obx(() {
                if (bluetoothController.isConnectedToRedmi9.value) {
                  return Text('Estás conectado al Redmi 9');
                } else if (!bluetoothController.isBluetoothOn.value) {
                  return Text(
                      'Por favor, enciende tu Bluetooth para continuar');
                } else if (bluetoothController.isScanning) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: bluetoothController.devices.length,
                    itemBuilder: (context, index) {
                      ScanResult device = bluetoothController.devices[index];
                      return ListTile(
                        title: Text(
                            device.device.name ?? 'Dispositivo desconocido'),
                        subtitle: Text('RSSI: ${device.rssi}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            bluetoothController.connectToDevice(device.device);
                          },
                          child: Text('Conectar disp'),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

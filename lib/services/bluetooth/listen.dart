import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothControllerListen extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  RxBool isConnected = false.obs; // Observable para indicar si está conectado
  bool isScanning = false; // Variable para controlar si se está escaneando
  RxBool isBluetoothOn = false.obs;
  List<ScanResult> devices = []; // Lista de dispositivos encontrados
  Rx<ScanResult?> connectedDevice = Rx<ScanResult?>(null);
  RxBool isConnectedToRedmi9 = false.obs;

  @override
  void onInit() {
    super.onInit();
    scanDevices();
    checkBluetoothStatus();
  }

  Future<void> checkBluetoothStatus() async {
    bool bluetoothEnabled = await flutterBlue.isOn;
    isBluetoothOn.value = bluetoothEnabled;
  }

  Future<void> scanDevices() async {
    // Verificar si ya se está escaneando
    if (!isBluetoothOn.value) {
      await checkBluetoothStatus(); // Actualizar el estado del Bluetooth antes de mostrar el SnackBar
      if (!isBluetoothOn.value) {
        Get.snackbar('Enciende tu Bluetooth',
            'Por favor, enciende tu Bluetooth para continuar');
        return;
      }
    }
    if (isScanning) {
      print(isScanning);
      return; // Salir si ya está en curso un escaneo
    }

    isScanning = true; // Marcar que se está iniciando un escaneo

    try {
      devices.clear();
      // Start scanning
      flutterBlue.startScan(timeout: Duration(seconds: 4));

      // Listen to scan results
      var subscription = flutterBlue.scanResults.listen((results) {
        // Check if the device is found
        for (ScanResult r in results) {
          devices.add(r);
          if (r.device.name == 'Redmi 9') {
            connectedDevice.value = r;
            isConnectedToRedmi9.value = true;
            isConnected.value = true;
            print('Nombre: ${r.device.name}');
            print('Dirección MAC: ${r.device.id}');
            print('RSSI: ${r.rssi}');
            print('Tipo de dispositivo: ${r.device.type}');
            print('Servicios UUID: ${r.advertisementData.serviceUuids}');
            print(
                'Datos del fabricante: ${r.advertisementData.manufacturerData}');
            break;
          }
        }
      });
    } finally {
      // Detener el escaneo y marcar que se ha completado
      isScanning = false;
      flutterBlue.stopScan();
    }
    // Stop scanning
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      print('Intentando conectar a ${device.name}...');
      // Mostrar el loader
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      await device.connect();

      // Ocultar el loader después de la conexión
      Get.back();

      print('Conectado a ${device.name} correctamente.');
      Get.snackbar('Conectado', 'Conectado a ${device.name} correctamente.');

      // Puedes agregar lógica adicional después de la conexión aquí

      // Escanear nuevamente dispositivos después de la conexión exitosa
      scanDevices();
    } catch (e) {
      // En caso de error, imprimirlo en la consola y mostrar un mensaje
      print('Error al conectar: $e');
      Get.snackbar(
          'Error al conectar', 'Hubo un error al conectar a ${device.name}.');
    }
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}

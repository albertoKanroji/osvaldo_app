import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final String targetDeviceMac = '64:a2:00:ac:a1:b1';
  final RxBool isConnected = false.obs;
  final RxBool isBluetoothOn = false.obs;
  final RxString connectionStatus = ''.obs;
  final RxBool isScanning = false.obs;
  BluetoothDevice? connectedDevice;
  final RxList<ScanResult> devices = <ScanResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestPermissions();
    listenBluetoothState();
  }

  @override
  void onClose() {
    stopScan();
    super.onClose();
  }

  void scanDevices() {
    isScanning.value = true;
    flutterBlue.startScan(timeout: Duration(seconds: 10));

    flutterBlue.scanResults.listen((results) {
      devices.assignAll(results);
    });
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise
    ].request();

    if (statuses[Permission.location]?.isGranted == true &&
        statuses[Permission.bluetoothScan]?.isGranted == true &&
        statuses[Permission.bluetoothConnect]?.isGranted == true &&
        statuses[Permission.bluetoothAdvertise]?.isGranted == true) {
      checkBluetoothState();
    } else {
      Get.snackbar('Permiso denegado',
          'Se requiere permiso de ubicación y Bluetooth para usar esta funcionalidad.');
    }
  }

  void listenBluetoothState() {
    flutterBlue.state.listen((state) {
      isBluetoothOn.value = state == BluetoothState.on;
      if (isBluetoothOn.value && !isScanning.value) {
        scanAndConnect();
      } else {
        connectionStatus.value =
            'Bluetooth está apagado. Por favor, enciéndelo.';
      }
    });
  }

  void checkBluetoothState() async {
    var state = await flutterBlue.state.first;
    isBluetoothOn.value = state == BluetoothState.on;
    if (isBluetoothOn.value && !isScanning.value) {
      scanAndConnect();
    } else {
      connectionStatus.value = 'Bluetooth está apagado. Por favor, enciéndelo.';
    }
  }

  void scanAndConnect() async {
    if (isScanning.value) {
      connectionStatus.value = 'Escaneo ya en progreso.';
      return;
    }

    isScanning.value = true;
    connectionStatus.value = 'Escaneando dispositivos...';
    await flutterBlue.startScan(timeout: Duration(seconds: 5)).catchError((e) {
      connectionStatus.value = 'Error iniciando escaneo: $e';
      isScanning.value = false;
    });

    flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        if (r.device.id.id == targetDeviceMac) {
          await flutterBlue.stopScan();
          isScanning.value = false;
          connectionStatus.value = 'Conectando a ${r.device.name}...';
          try {
            await r.device.connect();
            isConnected.value = true;
            connectedDevice = r.device;
            connectionStatus.value = 'Conectado a ${r.device.name}';
            printDeviceDetails(r.device);
            break;
          } catch (e) {
            connectionStatus.value = 'Error al conectar: $e';
          }
        }
      }

      if (!isConnected.value) {
        connectionStatus.value =
            'No se encontró el dispositivo. Intenta de nuevo.';
      }
    });

    isScanning.value = false;
  }

  void printDeviceDetails(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      print('Service: ${service.uuid}');
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        List<int> value = await characteristic.read();
        print('Characteristic: ${characteristic.uuid}, Value: $value');
      }
    }
  }

  void turnOnBluetooth() {
    Get.snackbar(
        'Bluetooth', 'Por favor, enciende Bluetooth desde los ajustes.');
  }

  void disconnect() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      isConnected.value = false;
      connectionStatus.value = 'Desconectado';
    }
  }
}

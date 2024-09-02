import 'package:osvaldo_app/services/bluetooth/listen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  BluetoothControllerListen bluetoothController =
      Get.put(BluetoothControllerListen());

  @override
  void onInit() {
    super.onInit();
  }
}

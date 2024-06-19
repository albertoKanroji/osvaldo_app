import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osvaldo_app/views/listaPersona/listaPersona.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Osvaldo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(() => const UserListPage());
              },
              child: const Text('Personas Registradas'),
            ),
            const SizedBox(height: 16), // Espacio entre los botones
            ElevatedButton(
              onPressed: () {
                // Aquí puedes manejar la acción del botón
              },
              child: const Text('Registrar Persona'),
            ),
          ],
        ),
      ),
    );
  }
}

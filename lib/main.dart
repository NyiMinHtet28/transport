import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_transport/singup.dart'; // Assuming Login widget is in login.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const GetMaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String _title = 'Public Transport Directory';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Public Transport Directory',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 250, // Adjust as needed
              height: 250, // Adjust as needed
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'), // Path to your image asset
                  fit: BoxFit.contain, // Adjust as needed
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                 Get.to(MyStatefulWidget());
              },
              child: const Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}

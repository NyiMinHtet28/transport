import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_transport/Navbar.dart';
import 'package:public_transport/addedlocation.dart';
import 'package:public_transport/singup.dart';
import 'package:public_transport/taxi.dart';
import 'package:public_transport/train.dart';

class TransportHomePage extends StatelessWidget {
  const TransportHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      drawer: navbar(), 
      appBar: AppBar(
          centerTitle: true,
          title: Text("Public Transport"),
          backgroundColor: Color.fromARGB(255, 44, 128, 139),
        ),
        
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ALL TRANSPORT:',
              style: TextStyle(fontSize: 20.0),
            ),
            TransportOptionCard(
              img: 'images/bus1.gif',
              title: 'Bus',
              description: 'Find Bus routes and schedules.',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BusSearchPage()),
                // );
                Get.to(BusSearchPage());
              },
            ),
            TransportOptionCard(
              img: 'images/train1.gif',
              title: 'Train',
              description: 'Explore train routes and schedules.',
              onPressed: () {
                Get.to(TrainSearchPage());
              },
            ),
            TransportOptionCard(
              img: 'images/taxi.gif',
              title: 'Taxi',
              description: 'Explore Taxi routes and schedules.',
              onPressed: () {
                Get.to(TaxiSearchPage());
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
              Get.to(MyStatefulWidget());
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

class TransportOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final String img;

  const TransportOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image.asset(img, width: 80, height: 80),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class AddBusPage extends StatefulWidget {
  final List<String> locations;
  final Function(Bus) onAddBus;

  AddBusPage({required this.locations, required this.onAddBus});

  @override
  _AddBusPageState createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  final TextEditingController busNameController = TextEditingController();
  String? fromLocation;
  String? toLocation;

  void addBus() {
    final busName = busNameController.text;
    if (busName.isNotEmpty && fromLocation != null && toLocation != null) {
      final bus = Bus(
        name: busName,
        from: fromLocation!,
        to: toLocation!,
      );
      widget.onAddBus(bus);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bus'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.lightBlue.shade50,
        child: Column(
          children: [
            TextField(
              controller: busNameController,
              decoration: InputDecoration(
                labelText: 'Bus Name',
                prefixIcon: Icon(Icons.directions_bus),
              ),
            ),
            DropdownButtonFormField<String>(
              value: fromLocation,
              decoration: InputDecoration(
                labelText: 'From Location',
                prefixIcon: Icon(Icons.location_on), // Added icon
              ),
              items: widget.locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  fromLocation = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: toLocation,
              decoration: InputDecoration(
                labelText: 'To Location',
                prefixIcon: Icon(Icons.location_on), // Added icon
              ),
              items: widget.locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  toLocation = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: addBus,
              icon: Icon(Icons.directions_bus),
              label: Text('Add Bus'),
            ),
          ],
        ),
      ),
    );
  }
}

class Bus {
  final String from;
  final String to;
  final String name;

  Bus({required this.from, required this.to, required this.name});
}

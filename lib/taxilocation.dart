import 'package:flutter/material.dart';

class AddTaxiPage extends StatefulWidget {
  final List<String> locations;
  final Function(Taxi) onAddTaxi;

  AddTaxiPage({required this.locations, required this.onAddTaxi});

  @override
  _AddTaxiPageState createState() => _AddTaxiPageState();
}

class _AddTaxiPageState extends State<AddTaxiPage> {
  final TextEditingController taxiNameController = TextEditingController();
  String? fromLocation;
  String? toLocation;

  void addTaxi() {
    
    final taxiName = taxiNameController.text;
    if (taxiName.isNotEmpty && fromLocation != null && toLocation != null) {
      final taxi = Taxi(
        name: taxiName,
        from: fromLocation!,
        to: toLocation!,
      );
      widget.onAddTaxi(taxi);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Taxi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taxiNameController,
              decoration: InputDecoration(
                labelText: 'Taxi Name',
              ),
            ),
            DropdownButtonFormField<String>(
              value: fromLocation,
              decoration: InputDecoration(labelText: 'From Location'),
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
              decoration: InputDecoration(labelText: 'To Location'),
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
            ElevatedButton(
              onPressed: addTaxi,
              child: Text('Add Taxi'),
            ),
          ],
        ),
      ),
    );
  }
}

class Taxi {
  final String from;
  final String to;
  final String name;

  Taxi({required this.from, required this.to, required this.name});
}

import 'package:flutter/material.dart';
import 'package:public_transport/transport.dart';

class AddTrainPage extends StatefulWidget {
  final List<String> locations;
  final Function(Train) onAddTrain;

  AddTrainPage({required this.locations, required this.onAddTrain});

  @override
  _AddTrainPageState createState() => _AddTrainPageState();
}

class _AddTrainPageState extends State<AddTrainPage> {
  final TextEditingController trainNameController = TextEditingController();
  String? fromLocation;
  String? toLocation;

  void addTrain() {
    final trainName = trainNameController.text;
    if (trainName.isNotEmpty && fromLocation != null && toLocation != null) {
      final train = Train(
        name: trainName,
        from: fromLocation!,
        to: toLocation!,
      );
      widget.onAddTrain(train);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Train'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.lightBlue.shade50,
        child: Column(
          children: [
            TextField(
              controller: trainNameController,
              decoration: InputDecoration(
                labelText: 'Train Name',
                 prefixIcon: Icon(Icons.train),
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
              onPressed: addTrain,
              icon: Icon(Icons.train),
              label: Text('Add Train'),
            ),
           
          ],
        ),
      ),
    );
  }
}

class Train {
  final String from;
  final String to;
  final String name;

  Train({required this.from, required this.to, required this.name});
}

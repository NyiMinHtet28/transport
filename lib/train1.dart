import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_transport/addlocation1.dart';
import 'package:public_transport/trainservice.dart';
import 'package:public_transport/transport.dart';

void main() {
  runApp(TrainScheduleApp());
}

class TrainScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Train Schedule',
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrainSearchPage2(),
    );
  }
}

class TrainSearchPage2 extends StatefulWidget {
  @override
  _TrainSearchPageState createState() => _TrainSearchPageState();
}

class _TrainSearchPageState extends State<TrainSearchPage2> {
  final List<String> locations = ['City A', 'City B', 'City C'];
  String? fromLocation;
  String? toLocation;
  final List<Bus> buses = [];
  final List<Train> trains = [];

  List<Train> filteredTrains = [];

  void searchTrains() {
    setState(() {
      filteredTrains = trains.where((train) {
        final fromMatch = fromLocation == null || train.from == fromLocation;
        final toMatch = toLocation == null || train.to == toLocation;
        return fromMatch && toMatch;
      }).toList();
    });
  }

  void addLocation(String location) {
    setState(() {
      locations.add(location);
    });
  }

  void addTrain(Train train) {
    setState(() {
      trains.add(train);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Schedule'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(const TransportHomePage());
          },
        ),
      ),
      
      body: Container(
        color: Colors.lightBlue.shade50, // Set the background color here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: fromLocation,
              decoration: InputDecoration(
                labelText: 'From Location',
                prefixIcon: Icon(Icons.location_on),
              ),
              items: locations.map((String location) {
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
                prefixIcon: Icon(Icons.location_on),
              ),
              items: locations.map((String location) {
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
              onPressed: searchTrains,
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocationPage(onAddLocation: addLocation),
                  ),
                );
              },
              icon: Icon(Icons.location_on),
              label: Text('Add Location'),
            ),
            SizedBox(height: 20),
            
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTrainPage(
                      locations: locations,
                      onAddTrain: addTrain,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.train),
              label: Text('Add Train'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTrains.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.train),
                    title: Text(filteredTrains[index].name),
                    subtitle: Text('${filteredTrains[index].from} to ${filteredTrains[index].to}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainDetailsPage(
                            trainName: filteredTrains[index].name,
                            fromLocation: filteredTrains[index].from,
                            toLocation: filteredTrains[index].to,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrainDetailsPage extends StatelessWidget {
  final String trainName;
  final String fromLocation;
  final String toLocation;

  TrainDetailsPage({required this.trainName, required this.fromLocation, required this.toLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trainName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Train Name: $trainName', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('From: $fromLocation', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('To: $toLocation', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class AddLocationPage extends StatefulWidget {
  final Function(String) onAddLocation;

  AddLocationPage({required this.onAddLocation});

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final TextEditingController locationController = TextEditingController();

  void addLocation() {
    final location = locationController.text;
    if (location.isNotEmpty) {
      widget.onAddLocation(location);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        
        color: Colors.lightBlue.shade50,
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location Name',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: addLocation,
              icon: Icon(Icons.add),
              label: Text('Add'),
            ),
            
          ],
        ),
      ),
    );
  }
}

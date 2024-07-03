import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_transport/addlocation1.dart';
import 'package:public_transport/transport.dart';


class BusSearchPage extends StatefulWidget {
  @override
  _BusSearchPageState createState() => _BusSearchPageState();
}

class _BusSearchPageState extends State<BusSearchPage> {
  final List<String> locations = ['City A', 'City B', 'City C'];
  String? fromLocation;
  String? toLocation;
  final List<Bus> buses = [];

  List<Bus> filteredBuses = [];

  void searchBuses() {
    setState(() {
      filteredBuses = buses.where((bus) {
        final fromMatch = fromLocation == null || bus.from == fromLocation;
        final toMatch = toLocation == null || bus.to == toLocation;
        return fromMatch && toMatch;
      }).toList();
    });
  }

  void addLocation(String location) {
    setState(() {
      locations.add(location);
    });
  }

  void addBus(Bus bus) {
    setState(() {
      buses.add(bus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Directory'),
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
              onPressed: searchBuses,
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
                    builder: (context) => AddBusPage(
                      locations: locations,
                      onAddBus: addBus,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.directions_bus),
              label: Text('Add Bus'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBuses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.directions_bus),
                    title: Text(filteredBuses[index].name),
                    subtitle: Text('${filteredBuses[index].from} to ${filteredBuses[index].to}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusDetailsPage(
                            busName: filteredBuses[index].name,
                            fromLocation: filteredBuses[index].from,
                            toLocation: filteredBuses[index].to,
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

class BusDetailsPage extends StatelessWidget {
  final String busName;
  final String fromLocation;
  final String toLocation;

  BusDetailsPage({required this.busName, required this.fromLocation, required this.toLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(busName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bus Name: $busName', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              icon: Icon(Icons.location_on),
              
              label: Text('Add'),
              
            ),
            
          ],
        ),
      ),
    );
  }
  
}

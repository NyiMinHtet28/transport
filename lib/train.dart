import 'package:flutter/material.dart';


class TrainSearchPage extends StatefulWidget {
  @override
  _TrainSearchPageState createState() => _TrainSearchPageState();
}

class _TrainSearchPageState extends State<TrainSearchPage> {
  final List<String> locations = ['City A', 'City B', 'City C'];
  String? fromLocation;
  String? toLocation;
  final List<Train> trains = [];
  List<Train> filteredTrains = [];
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      buildSearchPage(),
      AddLocationPage(onAddLocation: addLocation),
      AddTrainPage(locations: locations, onAddTrain: addTrain),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Train Schedule'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Add Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train),
            label: 'Add Train',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildSearchPage() {
    return Container(
      color: Colors.lightBlue.shade50,
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
      body: Container(
        color: Colors.lightBlue.shade50,
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
              icon: Icon(Icons.location_on),
              label: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTrainPage extends StatefulWidget {
  final List<String> locations;
  final Function(Train) onAddTrain;

  AddTrainPage({required this.locations, required this.onAddTrain});

  @override
  _AddTrainPageState createState() => _AddTrainPageState();
}

class _AddTrainPageState extends State<AddTrainPage> {
  final TextEditingController nameController = TextEditingController();
  String? fromLocation;
  String? toLocation;

  void addTrain() {
    final name = nameController.text;
    if (name.isNotEmpty && fromLocation != null && toLocation != null) {
      final train = Train(name: name, from: fromLocation!, to: toLocation!);
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
        color: Color.fromARGB(255, 7, 81, 116),
        
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Train Name',
                prefixIcon: Icon(Icons.train),
              ),
            ),
            DropdownButtonFormField<String>(
              value: fromLocation,
              decoration: InputDecoration(
                labelText: 'From Location',
                prefixIcon: Icon(Icons.location_on),
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
                prefixIcon: Icon(Icons.location_on),
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
              icon: Icon(Icons.add),
              label: Text('Add Train'),
            ),
          ],
        ),
      ),
    );
  }
}

class Train {
  final String name;
  final String from;
  final String to;

  Train({required this.name, required this.from, required this.to});
}

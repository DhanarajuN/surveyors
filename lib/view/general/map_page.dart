import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapPage extends StatefulWidget {
  @override
  _CustomMapPageState createState() => _CustomMapPageState();
}

class _CustomMapPageState extends State<CustomMapPage> {
  late GoogleMapController _mapController;
  LatLng _selectedLocation = LatLng(28.634, 77.180);

  // Function to handle map creation
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  // Function to handle marker placement
  void _placeMarker(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
    // You can also move the camera to the selected location if needed
    _mapController.animateCamera(CameraUpdate.newLatLng(position));
  }

  // Function to handle location confirmation
  void _confirmLocation() {
    // Perform actions like closing the page and returning the selected address
    Navigator.pop(context, _selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194), // Initial map center
              zoom: 12.0, // Initial zoom level
            ),
            onTap: _placeMarker,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Open address search dialog or input field
                      // Implement this part as needed
                    },
                    child: Text('Set Location'),
                  ),
                  ElevatedButton(
                    onPressed: _selectedLocation != LatLng(28.634, 77.180) ? _confirmLocation : null,
                    child: Text('Confirm Location'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

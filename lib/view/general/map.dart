import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  String address = '';
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194), // Default position (San Francisco)
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
              });
            },
            onTap: (LatLng latLng) {
              _getAddressFromLatLng(latLng);
            },
          ),
          if (address.isNotEmpty) // Display selected address
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  _onAddressClicked();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Address: $address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (selectedLocation != null) // Display confirm button
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedLocation);
                },
                child: Text('Confirm Location'),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    // Implement reverse geocoding to get the address from the latitude and longitude
    // For example, you can use the Geocoding API provided by Google Maps or another geocoding service
    // Once you have the address, update the state with the selected address and coordinates
    setState(() {
      selectedLocation = latLng;
      address = '123 Example St, City, Country'; // Replace with actual address
    });
  }

  void _onAddressClicked() {
    // Implement the action you want to take when the address is clicked
    print('Address clicked: $address');
  }
}

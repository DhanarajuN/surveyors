
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/local_store_helper.dart';
import '../../res/constants/routes_constants.dart';
import 'map.dart';

class BasicLocationDetailsScreen extends StatefulWidget {
  const BasicLocationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BasicLocationDetailsScreen> createState() =>
      _BasicLocationDetailsScreenState();
}

class _BasicLocationDetailsScreenState
    extends State<BasicLocationDetailsScreen> {
  String? selectedRange;
  bool isSelected = false;

  var items = ['10Km', '20Km', '30Km', '40Km', '50Km'];
  Map<String, dynamic>? surveyorData = {};
  TextEditingController slaNoController = TextEditingController(text: '');
  TextEditingController slaNoBapController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController effectiveDateController =
      TextEditingController(text: '');
  TextEditingController licenseExpiryDateController =
      TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController membershipNoController =
      TextEditingController(text: '');
  TextEditingController mobileController = TextEditingController(text: '');
  TextEditingController latitudeController =
      TextEditingController(text: '');
  TextEditingController longitudeController =
      TextEditingController(text: '');
  TextEditingController rangeController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    getLocalStorage();
  }

  getLocalStorage() async {
    // Simulated data for demonstration
    // Replace the function readJsonData with your actual implementation
    surveyorData = await readJsonData('surveyorData');
    selectedRange=await readTheData('Range');

    setState(() {
      // Set data to respective controllers
      selectedRange=selectedRange;
      slaNoController.text = surveyorData!['Ind SLA No'] ?? '';
      slaNoBapController.text = surveyorData!['Ind Sla No Bap Format'] ?? '';
      nameController.text = surveyorData!['Ind Surveyor Name'] ?? '';
      effectiveDateController.text =
          surveyorData!['License Effective Date'] ?? '';
      licenseExpiryDateController.text = surveyorData!['License Expiry Date'];
      mobileController.text = surveyorData!['Mobile Number'];

      // Concatenate address lines and set to address controller
      addressController.text = surveyorData!['Address Line 1']! +
          ' ' +
          surveyorData!['Address Line 2']! +
          ' ' +
          surveyorData!['Address Line 3']! +
          ' ' +
          surveyorData!['Address PIN']!;
      _getCoordinatesFromAddress();
      membershipNoController.text = surveyorData!['IIISLA Membership No'] ?? '';
      if(selectedRange!.isNotEmpty){
        isSelected=true;
      }
    });
  }

  Future<void> openMap(
      String address, double latitude, double longitude) async {
    String query;
    if (address.isNotEmpty) {
      query = Uri.encodeComponent(address);
    } else {
      // If address is empty, use latitude and longitude
      query = '$latitude,$longitude';
    }

    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 25),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //xGoRouter.of(context).go(RoutesList.dashBoard);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildProfileSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Personal Information'),
            _buildTextFormField('Name:', nameController, inputType: 'text'),
            _buildTextFormField('Mobile Number', mobileController,
                inputType: 'number'),
            _buildTextFormField('Ind Sla No Bap Format:', slaNoBapController),
            _buildTextFormField('Membership No:', membershipNoController),
            SizedBox(height: 20),
            _buildSectionTitle('Date Information'),
            _buildTextFormField('Effective Date:', effectiveDateController),
            _buildTextFormField('Expiry Date:', licenseExpiryDateController),
            SizedBox(height: 20),
            _buildSectionTitle('Location Information'),
            // _buildTextFormFieldWithMap(
            //   'Address:',
            //   addressController,
            //   inputType: 'map',
            //   context: context,
            // ),
            _buildTextFormField('Address', addressController,inputType: 'address'),
            _buildTextFormField('Latitude:', latitudeController),
            _buildTextFormField('Longitude:', longitudeController),
            
            SizedBox(height: 20),
            _buildSectionTitle('Select Range'),
            _buildDropdownField(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: isSelected
              ? () => GoRouter.of(context).go(RoutesList.dashBoard)
              : null, // Example navigation
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Continue'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue : Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            // Placeholder image, replace with actual user image
            backgroundImage: AssetImage('assets/images/user_image.jpg'),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            surveyorData!['Email Address'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

Widget _buildTextFormField(String label, TextEditingController controller,
    {String? inputType, BuildContext? context}) {
  TextInputType? keyboardType;
  Function? onTap;

  switch (inputType) {
    case 'text':
      keyboardType = TextInputType.text;
      onTap = null;
      break;
    case 'number':
      keyboardType = TextInputType.number;
      onTap = null;
      break;
    case 'date':
      keyboardType = TextInputType.none;
      onTap = () {
        // Show date picker when tapped
        _selectDate(context!, controller);
      };
      break;
    case 'address':
      keyboardType = TextInputType.text;
      onTap = null; // Remove onTap function for address field
      break;
    default:
      keyboardType = TextInputType.none;
      onTap = null;
  }

  return Column(
    children: [
      SizedBox(
        height: 12,
      ),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onTap: onTap as void Function()?,
        onChanged: (value) {
          // Call _getCoordinatesFromAddress() when the address field is changed
          if (inputType == 'address') {
            _getCoordinatesFromAddress(); // Update coordinates when address changes
          }
        },
        maxLines: null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );
}


  Widget _buildTextFormFieldWithMap(
      String label, TextEditingController controller,
      {String? inputType, BuildContext? context}) {
    return GestureDetector(
      onTap: () {
        // Replace latitude and longitude with actual values
        // Navigator.of(context!).push(
        //             MaterialPageRoute(
        //               builder: (context) => MapScreen(),
        //             ),
        //           );
      },
      child: _buildTextFormField(label, controller,
          inputType: inputType, context: context),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Format the picked date and set it to the controller
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      controller.text = formattedDate;
    }
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Range:',
        border: OutlineInputBorder(),
      ),
      value: selectedRange,
      onChanged: (String? newValue) {
        setState(() {
          isSelected = true;

          selectedRange = newValue;
          writeTheData('Range', '$newValue');
          rangeController.text = selectedRange!;
        });
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

Future<void> _getCoordinatesFromAddress() async {
  try {
    if (addressController.text.isEmpty) {
      throw 'Address is empty';
    }
    
    List<Location> locations = await locationFromAddress(addressController.text);
    if (locations.isNotEmpty) {
      setState(() {
        latitudeController.text = '${locations.first.latitude}';
        longitudeController.text = '${locations.first.longitude}';
      });
    } else {
      throw 'No coordinates found for the provided address';
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      latitudeController.text = '';
      longitudeController.text = '';
    });
  }
}

}

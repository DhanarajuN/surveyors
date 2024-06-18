import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../res/constants/routes_constants.dart';

class AmountRangeScreen extends StatefulWidget {
  const AmountRangeScreen({Key? key}) : super(key: key);

  @override
  State<AmountRangeScreen> createState() => _AmountRangeScreenState();
}

class _AmountRangeScreenState extends State<AmountRangeScreen> {
  int? _selectedRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 25),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 20),
              Text(
                'Select Amount Range (in Indian Rupees):',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<int>(
                    title: Text('Up to ₹1,00,000'),
                    value: 0,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('₹1,00,000 - ₹5,00,000'),
                    value: 1,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('₹5,00,000 - ₹10,00,000'),
                    value: 2,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('₹10,00,000 - ₹50,00,000'),
                    value: 3,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('₹50,00,000 - ₹1,00,00,000'),
                    value: 4,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('₹1,00,00,000 - ₹5,00,00,000'),
                    value: 5,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('₹5,00,00,000 - ₹10,00,00,000'),
                    value: 6,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('More than ₹10,00,00,000'),
                    value: 7,
                    groupValue: _selectedRange,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRange = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: _selectedRange != null
              ? () {
                  GoRouter.of(context).push(RoutesList.dashBoard);
                }
              : null,
          child: Text('Continue'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedRange != null ? Colors.blue : Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:Surveyors/res/constants/image_constants.dart';
import 'package:flutter/material.dart';

class InsurencePage extends StatefulWidget {
  const InsurencePage({super.key});

  @override
  State<InsurencePage> createState() => _InsurencePageState();
}

class _InsurencePageState extends State<InsurencePage> {
  final List<Map<String, dynamic>> gridList = [
    {'image': ImageConstants.insurenceGridLogo, 'title': "Family Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Health Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Accident Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Family Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Claim Documents"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Health Checkup"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Health eCard"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Medicine Discount"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Family Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Network Hospitals"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "About Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "Mobile Insurence"},
    {'image': ImageConstants.insurenceGridLogo, 'title': "2-wheeler Insurence"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 150),
            itemCount: gridList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3.0,
                          color: Colors.grey.shade200,
                          spreadRadius: 3.0,
                          offset: const Offset(0, 3)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("${gridList[index]["image"]}"),
                      fit: BoxFit.none,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${gridList[index]["title"]}",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

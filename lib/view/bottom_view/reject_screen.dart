import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../push_notification.dart';
import '../../res/constants/custom_textstyle.dart';

class RejectScreen extends StatefulWidget {
  const RejectScreen({super.key});

  @override
  State<RejectScreen> createState() => _RejectScreenState();
}

class _RejectScreenState extends State<RejectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(2.0), child: insuranceBody());
          }),
    );
  }

  Widget insuranceBody() {
    return   GestureDetector(
    onTap: () {
       LocalNotificationService.display(RemoteMessage(
                              notification: RemoteNotification(
                                title: "Accepted",
                                body: "Your message body",
                              ),
                            )); 
      // Add your onTap logic here
      print('Insurance body clicked');
      // You can navigate to another screen or perform any action here
    },
    child:
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
        child: Card(
          shadowColor: Colors.grey,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'CLAIM NO:',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Ca-1533063021215',
                          style: KTextStyle.regularDescFontStyle,
                        ),
                      ],
                    ),
                    // Text(
                    //   'Rejeted',
                    //   style: TextStyle(
                    //     color: Colors.red, // Set the color of the text to red
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 16.0,
                    //   ),
                    // ),
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NAME:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      'Shyam',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MOBILE NO:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      '943337469',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LOCATION:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      'Madhapur',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DISTANCE:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      '2KM',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         // Add your first button action here
                //       },
                //       child: Text('Edit'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         // Add your second button action here
                //       },
                //       child: Text('Directions'),
                //     ),
                //   ],
                // ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     width: double
                //         .infinity, // Set the width to match the parent's width
                //     child: ElevatedButton(
                //       onPressed: () {
                //         // Add your button action here
                //       },
                //       child: Text(
                //         'Edit',
                //         style: KTextStyle.appTitleFontStyle,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';

class EndUserDashboard extends StatefulWidget {
  const EndUserDashboard({super.key});

  @override
  State<EndUserDashboard> createState() => _EndUserDashboardState();
}

class _EndUserDashboardState extends State<EndUserDashboard> {
  bool checkBoxValue = false;
  var name = '';
  getUserDetails() async {
    var user = await readTheData('userName');
    setState(() {
      name = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' Welcome ${(name.isNotEmpty) ? name : ''}',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              // Text( (name.isNotEmpty) ? name : '',
              //   style: const TextStyle(color: Colors.black, fontSize: 16.0),
              // ),
            ],
          ),
        ),
        body: TopScreen(),
      ),
    );
  }

  Widget TopScreen() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Health is Wealth',
                            style: KTextStyle.regularTitleGreyFontStyle,
                          ),
                          Container(
                              height: 2.0, width: 30.0, color: Colors.pink),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.favorite_outline,
                                color: Colors.pink,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Home, Sweet Home',
                            style: KTextStyle.regularTitleGreyFontStyle,
                          ),
                          Container(
                              height: 2.0, width: 30.0, color: Colors.pink),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.home_outlined,
                                color: Colors.pink,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended For You ',
                  style: KTextStyle.semiBoldFontStyle,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: KTextStyle.semiBoldFontStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Recommend(),
          ],
        ),
      ),
    );
  }

  Widget Recommend() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'I Love',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Text(
                          'My Family',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Container(height: 2.0, width: 30.0, color: Colors.pink),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/users_40.png',
                              color: Colors.pink,
                              width: 24.0,
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'I Love',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Text(
                          'My Vehicle',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Container(height: 2.0, width: 30.0, color: Colors.pink),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/car_40.png',
                              color: Colors.pink,
                              width: 24.0,
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Let\'s ',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Text(
                          'Travel',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Container(height: 2.0, width: 30.0, color: Colors.pink),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/plane_40.png',
                              color: Colors.pink,
                              width: 24.0,
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Protect',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Text(
                          'My Things',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Container(height: 2.0, width: 30.0, color: Colors.pink),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/laptop_40.png',
                              color: Colors.pink,
                              width: 24.0,
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secure',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Text(
                          'My Child',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Container(height: 2.0, width: 30.0, color: Colors.pink),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/user.png',
                              color: Colors.pink,
                              width: 24.0,
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secure',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Text(
                          'My Future',
                          style: KTextStyle.semiBoldFontStyle,
                        ),
                        Container(height: 2.0, width: 30.0, color: Colors.pink),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/first_aid_40.png',
                              color: Colors.pink,
                              width: 24.0,
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

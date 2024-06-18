import 'dart:convert';
import 'dart:io';

import 'package:Surveyors/data_model/module_catgories.dart';
import 'package:Surveyors/model/navigation_model.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/common_method.dart';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:Surveyors/view/DashBoard/main_side_menu.dart';
import 'package:Surveyors/view/custom/alret_dialog.dart';
import 'package:Surveyors/view/general/interests.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/colors.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';
import 'package:Surveyors/res/constants/image_constants.dart';
import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:Surveyors/view/bottom_Navigation_screens/profile.dart';
import 'package:Surveyors/view/web_view.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../bottom_view/accept_screen.dart';
import '../bottom_view/all_claims.dart';
import '../bottom_view/available_screen.dart';
import '../bottom_view/dashboard_status.dart';
import '../bottom_view/reject_screen.dart';
import '../bottom_view/reoprts.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 1;
  int? _expandedIndex;
  String home = "Claims";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  String profileImage = '';
  String userName = '';
  String mail_id = '';
  String userId = '';
  String mallId = '';
  var accessToken = '';
  var role = '';
  var defaultUrl='';
  var responses = <http.Response>[];
  List<NavigationView>? sideViewModel = [];
  List<Jobs>? modulecategoriesModel = [];
  Map<String, dynamic> map = {};
  List<bool> _isExpandedList = [];
  bool visbleHome=true;
  bool isLoading=true;
  var _widgetOptions = [
    const AllClaimsScreen(),
    const DashboardStatus(),
    ReoprtsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    List<bool> _isExpandedList = List.filled(sideViewModel!.length, false);
    print('Dashboard screen called....${_isExpandedList}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.appColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${ApiConstants.appName}',
              style: KTextStyle.appTitleFontStyle,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: KColors.appColor,
          child: SafeArea(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  accountName: Text("123", style: KTextStyle.bold14BFontStyle),
                  accountEmail: Text(
                    mail_id,
                    style: KTextStyle.regularTextStyle,
                  ),
                  currentAccountPicture: const CircleAvatar(
                    radius: 1.0,
                    backgroundImage: AssetImage('assets/images/user_image.jpg'),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sideViewModel!.length,
                    itemBuilder: (context, index) {
                      var navigationModel = sideViewModel![index];

                      return Column(
                        children: [
                          ExpansionTile(
                            title: Text(
                              '${navigationModel.mainMenu!.name}',
                              style: KTextStyle.menuTextStyle,
                            ),
                            trailing: Icon(
                              _isExpandedList[index]
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            onExpansionChanged: (isExpanded) {
                              setState(() {
                                print("naMe:;::${navigationModel.mainMenu!.name}");
                                if(navigationModel.mainMenu!.name=='Home'){
                                  visbleHome=true;
                                  Navigator.pop(context);
                                  print("webUrl:${ApiConstants.webUrl+defaultUrl}");
                                }
                                print('main ${navigationModel.mainMenu!.name}');
                                navigationViewAction(
                                    '${navigationModel.mainMenu!.name}');
                                if (!isExpanded) {
                                  _isExpandedList[index] = false;
                                } else {
                                  // If the current tile is being expanded, close the previously expanded tile
                                  int previousIndex = _isExpandedList
                                      .indexWhere((value) => value);
                                  if (previousIndex != -1 &&
                                      previousIndex != index) {
                                    _isExpandedList[previousIndex] = false;
                                  }
                                  // Update the current ExpansionTile state
                                  _isExpandedList[index] = true;
                                }
                              });
                            },
                            initiallyExpanded: _isExpandedList[index],
                            childrenPadding: const EdgeInsets.only(left: 20),
                            children: [
                              // Populate the child items based on the selected parent item
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: modulecategoriesModel!
                                    .where((item) =>
                                        item.data!.moduleType ==
                                        navigationModel.id)
                                    .length,
                                itemBuilder: (context, index) {
                                  var filteredItems = modulecategoriesModel!
                                      .where((item) =>
                                          item.data!.moduleType ==
                                          navigationModel.id)
                                      .toList();
                                  // filteredItems =
                                  //     filteredItems.reversed.toList();
                                  var childNavigationModel =
                                      filteredItems[index];
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            '${childNavigationModel.data!.moduleLabel}',
                                            style: KTextStyle.menuTextStyle),
                                        onTap: () {
                                          setState(() {
                                            visbleHome=false;
                                            home =
                                                '${childNavigationModel.data!.moduleLabel}';
                                            _widgetOptions.clear;
                                            String homeType =
                                                '${childNavigationModel.data!.moduleEntryJobId}';
                                            updateWidgetOptions(homeType);
                                            Navigator.of(context).pop();
                                          });

                                          print('menu entry jobId:${home}');
                                          _onItemTapped(
                                              _selectedIndex == 0 ? 1 : 0);
                                          //_onItemTapped(1);

                                          print(
                                              "item Data:${childNavigationModel.data!.moduleLabel} ${navigationModel.id} ");
                                        },
                                      ),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          //  Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white24,
      body:visbleHome? !isLoading? Container(
        child: Center(
          child: MyWebView(url: ApiConstants.webUrl+defaultUrl,visibleAppbar: false,),
        ),
      ): null: 
       Container(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar:visbleHome?null: createBottomBar(context),
    );
  }

  void updateWidgetOptions(String homeType) {
    setState(() {
      _widgetOptions.clear();
      _widgetOptions = [
        AllClaimsScreen(
          type: homeType,
        ),
        DashboardStatus(type: homeType),
        ReoprtsScreen(
          type: homeType,
        )
      ];
    });
  }

  void navigationViewAction(String view) {
    if (view == 'Signout') {
      logout();

      GoRouter.of(context).push(RoutesList.login);
    } else if (view == 'Chat with Us') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyWebView(
                    url: '${ApiConstants.chatgptWebUrl}',
                  )));
    } else {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => ChatGptScreen(view)));
    }
  }

  logout() async {
    AppLoader.showLoader();
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); 
      AppLoader.hideLoader();
    });
  }

  getProfileImage() async {
    var name = await readTheData('userName');
    var id = await readTheData('userId');
    var mallid = await readTheData('mallId');
    // var image = await readTheData('profileImage');
    var mailId = await readTheData('userMail');
    accessToken = await readTheData('accessToken');
    role = await readTheData('role');
    // print(image);
    // print(name);
    // print(id);
    // print(mallid);
    setState(() {
      //profileImage = image;
      userName = name;
      userId = id;
      mallId = mallid;
      mail_id = mailId;
    });
    NavigationDetials();
  }

  void NavigationDetials() async {
    AppLoader.showLoader();
    var moduleConstants = ApiConstants.getMastersAPiAll('moduleconstants');
    Map<String, dynamic> moduleConstantsRes =
        await ServerCall.getRequest(moduleConstants, token: accessToken);

    var sideNavigation = ApiConstants.getMastersAPiAll('Module Type');
    map = await ServerCall.getRequest(sideNavigation, token: accessToken);

    var sideNavigationSubItems =
        ApiConstants.getMastersAPiAll('modulecategories');
    Map<String, dynamic> modulecategories =
        await ServerCall.getRequest(sideNavigationSubItems, token: accessToken);
    setState(() {
      if (moduleConstantsRes["jobs"] != null &&
    moduleConstantsRes["jobs"].isNotEmpty &&
    moduleConstantsRes["jobs"][0]["data"] != null &&
    moduleConstantsRes["jobs"][0]["data"]["defaultDashboardURL"] != null) {
  // If the field is present and has a value
  defaultUrl = moduleConstantsRes["jobs"][0]["data"]["defaultDashboardURL"];
  
} else {
  
  defaultUrl = "Home/singlejobView/powerDashboard"; 
}
      // defaultUrl=moduleConstantsRes["jobs"][0]["data"]["defaultDashboardURL"];
       if(defaultUrl.isNotEmpty){
        visbleHome=true;
        print('defaultUrl:${ApiConstants.webUrl+defaultUrl}');
       }
       isLoading=false;
      print('defaultUrl:${defaultUrl}');
      NavigationModel model = NavigationModel.fromJson(map);
      sideViewModel = model.jobs;
      _isExpandedList = List.filled(sideViewModel!.length, false);
      if (sideViewModel != null) {
        sideViewModel!.sort((a, b) => int.parse(a.mainMenu!.order!)
            .compareTo(int.parse(b.mainMenu!.order!)));
        sideViewModel!.removeWhere((item) =>
            (item.mainMenu!.restrictedRoles!.contains(role) ||
                item.current_job_status == 'Inactive'));
      }

      Modulecategories modulecategoriesRes =
          Modulecategories.fromJson(modulecategories);
      modulecategoriesModel = modulecategoriesRes.jobs;
      print('role:$role');
      print(modulecategoriesModel!.length);

      modulecategoriesModel!.removeWhere((item) =>
          (item.data?.restrictedRoles?.contains(role) ?? false) ||
          (item.current_job_status == 'Inactive'));

      print(modulecategoriesModel!.length);
    });
     AppLoader.hideLoader();
    // getNavigationDetails();
  }

  void getNavigationDetails() {
    // Assuming 'responses' is a list of API response strings
    String jsonResponse = responses[0].body;
    Map<String, dynamic> map = jsonDecode(jsonResponse);
  }

  void _onItemTapped(int index) {
    setState(() {
      // fetchCurrentLocation();

      _selectedIndex = index;
      // if (_selectedIndex == 2) {
      //   CommonMethod.externalBrowser(ApiConstants.chatgptWebUrl);
      // }
    });
  }

  Container createBottomBar(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: KColors.appColor,
          unselectedItemColor: Colors.grey,
          elevation: 10,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: home,
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                  Icons.dashboard), // Change icon to a shopping bag or similar
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline_sharp),
              label: 'Reports',
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  @override
  void initState() {
    //fetchCurrentLocation();
    getProfileImage();
    // TODO: implement initState
    _isExpandedList = List.filled(sideViewModel!.length, false);
    super.initState();
  }

  void fetchCurrentLocation() async {
    Position? currentPosition = await CommonMethod.requestLocationPermission();
    if (currentPosition != null) {
      print(
          'Current Location: ${currentPosition.latitude}, ${currentPosition.longitude}');
    } else {
      var dialog = CustomAlertDialog(
        message: 'Please enable location services to use this feature',
        title: 'Location Services Required',
        positiveBtnText: 'Enable',
        negativeBtnText: '',
        onPositivePressed: () async {
          await Geolocator.openLocationSettings();
        },
      );

      showDialog(
        context: context,
        builder: (BuildContext context) => dialog,
      );
      print('Failed to fetch location.');
    }
  }
}

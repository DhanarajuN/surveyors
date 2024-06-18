import 'package:Surveyors/view/DashBoard/main_side_menu.dart';

class NavigationModel {
  String? status;
  List<NavigationView>? jobs;

  NavigationModel({this.status, this.jobs});

  NavigationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['jobs'] != null) {
      jobs = <NavigationView>[];
      json['jobs'].forEach((v) {
        jobs!.add(NavigationView.fromJson(v));
      });
    }
  }
}

class NavigationView {
  String? id;
  MainMenu? mainMenu;
  String?current_job_status;

  NavigationView({this.id, this.mainMenu,this.current_job_status});

  NavigationView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainMenu = json['data'] != null ? MainMenu.fromJson(json['data']) : null;
    current_job_status=json['Current_Job_Status'];
  }
}

class MainMenu {
  String? name;
  String? order;
  String? restrictedRoles;

  MainMenu({this.name, this.order, this.restrictedRoles});

  MainMenu.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    order = json['Order'];
    restrictedRoles = json['Restricted_Roles'];
  }
}

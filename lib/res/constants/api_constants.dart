import 'dart:convert';
import 'package:Surveyors/res/components/loader.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  ApiConstants._();
  static const String appName = 'GoSure';
  static const String baseUrlPQMS = "https://pqms-uat.cgg.gov.in/pqms/";
  static const String clientID = "Client123Cgg";
  static const String endPoint_MobileLogin = "mobileLogin";
  static const String endPoint_ImportList = "getIROList";
  static const String endPoint_ExportList = "getPSCAppDetails";
  static const String endPoint_ImportApplicationDetails =
      "saveExportPermitAction";
  static const String endPoint_ExportApplicationDetails = "getPSCAppDetails";
  static const String endPoint_DutyOfficersList = "getEmployeeListByRole";
  static const String endPoint_AppTransactionDetails = "gettransactionsByAppId";
  static const String endPoint_IroTransaction = "saveIpIroInspectorAction";
  static const String endPoint_ExportTransaction = "saveExportPermitAction";
  static const String endPoint_VersionCheck = "getCurrentAppVersion";
  static const String endPoint_AgencyList = "agenciesList";
  static const String endPoint_IroTreatmentReport = "saveIpIroInspectorAction";
  static const String endPoint_PscTreatmentReport = "saveExportPermitAction";

  static const String baseUrl = 'https://dev-api.gosure.ai/';
  static const String webUrl='https://insurancedemo.gosure.ai/';
  static const String tenant=
  //'jcg';
 // 'smetemp';
  'bharathsurveyor1';
  static const String loginUrl = 'api/authentication/loginotp?username=';
  static const String validateOTP = 'api/authentication/loginvalidateotp?';
  static const String chatgptWebUrl =
      'http://bigdemo.gosure.ai/web/support?fromURL=true';
  static const String get_profileDetails =
      '${baseUrl}api/management/users/user?userId=';
  static const String update_profile = '${baseUrl}api/management/users/update';

  static const String addNewWebUrl =
      'http://bigdemo.gosure.ai/ENROLLMENT%20MODULE/registerJob/policy/Dependents';
  static const String jobCreate = '${baseUrl}JobsController/postedJobs?';

  static const String jobDelete = '${baseUrl}api/jobs/delete?jobId=';
  static String ajaxCall(int? orgId, int? userId, String? recognizer,
      String json, String fieldValue) {
    return '${baseUrl}api/jobs/ajaxdetails?orgId=$orgId&userid=$userId&recognizer=$recognizer&json=$json&fieldValue=$fieldValue';
  }

  static String updateJobsMetaData(
      String op, int userId, int? jobId, String userEmail) {
    return '${baseUrl}Services/updateConsumerJobMetaData?op=$op&userId=$userId&jobId=$jobId&userEmail=$userEmail';
  }

  // https://dev-api.gosure.ai/api/v1/job-types/name/Surveyors/instances?pageNumber=1&pageSize=10
  static String getMastersAPi(String jobtype, pagenNo, pageSize) {
    return '${baseUrl}api/v1/job-types/name/$jobtype/instances?pageNumber=$pagenNo&pageSize=$pageSize';
  }
  static String getMastersAPiAll(String jobtype) {
    return '${baseUrl}api/v1/job-types/name/$jobtype/instances';
  }

  static String getFilterApi(
      String jobtype, pagenNo, pageSize, status, statusValue) {
    if (statusValue == 'Total') {
      return '${baseUrl}api/v1/job-types/name/$jobtype/instances?pageNumber=$pagenNo&pageSize=$pageSize';
    }
    return '${baseUrl}api/v1/job-types/name/$jobtype/instances?pageNumber=$pagenNo&pageSize=$pageSize&filters=[{"fieldName":"jobWorkflowInstance.currentStep.${status}","condition":"is","value":"$statusValue"}]';
  }

//{{url}}/api/v1/job-types/name/Surveyors/fields
  static String getMastersFieldsAPi(String jobtype) {
    return '${baseUrl}api/v1/job-types/name/$jobtype/fields';
  }

//{{url}}/api/v1/job-instances/660e7183938a1f72ac681e7c
  static String instanceUrl(String id) {
    return '${baseUrl}api/v1/job-instances/$id';
  }

  //ht{tps://dev-api.gosure.ai/api/v1/job-workflows/job-type/name/Clientele/status
  static String statusApi(String jobtype) {
    return '${baseUrl}api/v1/job-workflows/job-type/name/$jobtype/status';
  }

  // https://gooddemo.gosure.ai/Surveyors/editJob/singlejobView/Claim Register/6618c9e82738eb463bfb83e5/edit?url=/Surveyors/editJob/policy/Surveyors/660e7183938a1f72ac681e7c/edit&jid=660e7183938a1f72ac681e7c
  static String editJob(String parentId, String childId) {
    return 'https://insurancedemo.gosure.ai/Surveyors/editJob/singlejobView/Claim Register/$childId/edit?url=/Surveyors/editJob/policy/Surveyors/$parentId/edit&jid=$parentId';
  }
  static String editJob1(String parentId,String jobtype) {
    return 'https://insurancedemo.gosure.ai/Claim%20Register/editJob/policy/${jobtype}/${parentId}/edit/onlyForm';
  }

//   https://sa4.insuranceportfolio.in:9081/Services/getMasters?type=Employees&mallId=7&keyWord=employee_12@gosure.ai
// jobs{id}
// {{ip_address}}/Services/getMasters?jobId=6710&associateId=6710

  dynamic getValueFromJson(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      return json[key];
    }
    return null;
  }

  static String constructUrl(
      @required String jsonEncoded,
      @required String type,
      @required int mallId,
      @required String userMailId,
      @required int jobId) {
    var url = '${baseUrl}/JobsController/postedJobs';

    var queryParameters = {
      'userId': mallId.toString(),
      'consumerEmail': userMailId,
      'type': type,
      'json': jsonEncoded,
      'dt': 'CAMPAIGNS',
      'category': 'Services',
      'parentJobId': jobId.toString(),
    };

    var uri = Uri.parse(url).replace(queryParameters: queryParameters);
    return uri.toString();

    // Extract the key-value message from the response
    // var message = responseBody['message'];
  }

  static postedJobApi(
      String jsonEncoded, String s, int mallId, String userMail, int jobId) {}
}

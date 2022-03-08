import 'package:suezcanal/Model/model_staff.dart';
import 'package:suezcanal/const/constant.dart';
import 'package:http/http.dart' as http;

class StaffData {
  StaffData();

  Future<String?> addStaff({required Staff2 staff}) async {
    String baseUrl = root + 'user.php';
    var map = {
      'action': 'CREATE_TABLE',
    };
    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      var map = {
        'action': 'ADD_USER',
        'name': staff.name,
        'phone': staff.phone,
        'image': staff.image,
        'generalSpecialty': staff.generalSpecialty,
        'specialization': staff.specialization,
        'masterDHistory': staff.masterDHistory,
        'phDHistory': staff.phDHistory,
        'universityName': staff.universityName,
      };
      var response = await http.post(Uri.parse(baseUrl), body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    }
  }

  Future<String?> updateStaff({required Staff2 staff}) async {
    String baseUrl = root + 'user.php';
      var map = {
        'action': 'UPDATE_USER',
        'name': staff.name,
        'phone': staff.phone,
        'image': staff.image,
        'generalSpecialty': staff.generalSpecialty,
        'specialization': staff.specialization,
        'masterDHistory': staff.masterDHistory,
        'phDHistory': staff.phDHistory,
        'universityName': staff.universityName,
      };
      var response = await http.post(Uri.parse(baseUrl), body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }

  }

  Future<String?> updateStaffNewPhone({required Staff2 staff , required newPhone}) async {
    String baseUrl = root + 'user.php';
    var map = {
      'action': 'UPDATE_USER_PHONE',
      'oldPhone' : newPhone,
      'name': staff.name,
      'phone': staff.phone,
      'image': staff.image,
      'generalSpecialty': staff.generalSpecialty,
      'specialization': staff.specialization,
      'masterDHistory': staff.masterDHistory,
      'phDHistory': staff.phDHistory,
      'universityName': staff.universityName,
    };
    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }

  }

  Future<String?> deleteStaff({required String id}) async {
    String baseUrl = root + 'user.php';
      var map = {
        'action': 'DELETE_USER',
        'post_id': id,
      };
      var response = await http.post(Uri.parse(baseUrl), body: map);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
    }
  }

  Future<AllStaffManagement?> getStaff() async {
    String baseUrl = root + 'allStaff.php';
    var map = {
      'action': 'CREATE_TABLE',
    };
    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return allStaffManagementFromJson(response.body);
      } else {
        return null;
      }
    }
  }
}

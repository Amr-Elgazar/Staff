import 'dart:convert';

AllStaffManagement allStaffManagementFromJson(String str) => AllStaffManagement.fromJson(json.decode(str));

String allStaffManagementToJson(AllStaffManagement data) => json.encode(data.toJson());

class AllStaffManagement {
  AllStaffManagement({
   required this.staff,
  });

  List<Staff> staff;

  factory AllStaffManagement.fromJson(Map<String, dynamic> json) => AllStaffManagement(
    staff: List<Staff>.from(json["Staff"].map((x) => Staff.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Staff": List<dynamic>.from(staff.map((x) => x.toJson())),
  };
}

class Staff {
  Staff({
  required this.id,
  required this.name,
  required this.phone,
  required this.image,
  required this.generalSpecialty,
  required this.specialization,
  required this.masterDHistory,
  required this.phDHistory,
  required this.universityName,
  });

  int id;
  String name;
  String phone;
  String image;
  String generalSpecialty;
  String specialization;
  String masterDHistory;
  String phDHistory;
  String universityName;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    id: int.parse(json["id"]),
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
    generalSpecialty: json["generalSpecialty"],
    specialization: json["specialization"],
    masterDHistory: json["masterDHistory"],
    phDHistory: json["phDHistory"],
    universityName: json["universityName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "image": image,
    "generalSpecialty": generalSpecialty,
    "specialization": specialization,
    "masterDHistory": masterDHistory,
    "phDHistory": phDHistory,
    "universityName": universityName,
  };
}

class Staff2 {
  Staff2({

    required this.name,
    required this.phone,
    required this.image,
    required this.generalSpecialty,
    required this.specialization,
    required this.masterDHistory,
    required this.phDHistory,
    required this.universityName,
  });


  String name;
  String phone;
  String image;
  String generalSpecialty;
  String specialization;
  String masterDHistory;
  String phDHistory;
  String universityName;

  factory Staff2.fromJson(Map<String, dynamic> json) => Staff2(

    name: json["name"],
    phone: json["phone"],
    image: json["image"],
    generalSpecialty: json["generalSpecialty"],
    specialization: json["specialization"],
    masterDHistory: json["masterDHistory"],
    phDHistory: json["phDHistory"],
    universityName: json["universityName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "image": image,
    "generalSpecialty": generalSpecialty,
    "specialization": specialization,
    "masterDHistory": masterDHistory,
    "phDHistory": phDHistory,
    "universityName": universityName,
  };
}

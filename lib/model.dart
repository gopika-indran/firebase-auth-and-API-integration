import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String employeeName;
  final int employeeSalary;
  final int employeeAge;
  final String profileImage;

  User({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      employeeName: json["employee_name"],
      employeeSalary: json["employee_salary"],
      employeeAge: json["employee_age"],
      profileImage: json["profile_image"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "employee_age": employeeAge,
        "profile_image": profileImage,
      };
}

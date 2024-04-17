import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mock/model.dart';
import 'package:mock/profile.dart';
import 'package:mock/single.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<User>> fetchDetail() async {
    final response = await get(
        Uri.parse("https://dummy.restapiexample.com/api/v1/employees"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["data"];
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("failed to load employees");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EMPLOYEE DETAILS"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileUser()));
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: FutureBuilder(
        future: fetchDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<User>? employees = snapshot.data;
            return ListView.builder(
              itemCount: employees!.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Singledetails(employsdetails: employee),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.blueAccent.withOpacity(0.2),
                      title: Row(
                        children: [
                          Text(
                            employee.id.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(employee.employeeName),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Singledetails extends StatelessWidget {
  final employsdetails;
  const Singledetails({super.key, required this.employsdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent.withOpacity(0.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ID: ${employsdetails.id}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Name: ${employsdetails.employeeName}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Salary: ${employsdetails.employeeSalary}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Age: ${employsdetails.employeeAge}"),
                  ],
                ),
              ),
            )

            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

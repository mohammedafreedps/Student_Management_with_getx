import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmanagementgetx/GetX/getxController.dart';
import 'package:studentmanagementgetx/Pages/studentAddPage.dart';
import 'package:studentmanagementgetx/Widgests/studentListWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentDatas = Get.put(studentDataState());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                  child: Text(
                'Students',
                style: TextStyle(fontSize: 40, color: Colors.grey),
              )),
              Divider(),
              SizedBox(
                height: 50,
              ),
              TextField(
                onChanged: (value){
                  studentDatas.searchAndUpdate(value);
                },
                decoration: InputDecoration(hintText: 'Search'),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: studentDatas.searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StudentListWidget(index: index);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 20, 20, 20),
          onPressed: () {
            Get.to(StudentAddPage());
          }),
    );
  }
}

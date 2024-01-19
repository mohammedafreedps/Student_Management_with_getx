import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmanagementgetx/GetX/getxController.dart';
import 'package:studentmanagementgetx/Pages/studentDetailPage.dart';
import 'package:studentmanagementgetx/Pages/studentEditPage.dart';

class StudentListWidget extends StatelessWidget {
  final int index;
  StudentListWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final studentData = Get.put(studentDataState());
    final current = studentData.searchResults[index];
    final res = current.studentmodel;
    print(current);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
            onTap: () {
              Get.to(StudentDetailPage(index: current.originalIndex,));
            },
            onLongPress: (){
              Get.defaultDialog(
                title: 'Delete/Edit',
                content: Text('Do you want to delete or Edit'),
                actions: [
                  ElevatedButton(onPressed: (){
                    Get.to(StudentEditPage(index: current.originalIndex));
                    
                  }, child: Text('Edit')),
                  ElevatedButton(onPressed: (){
                    studentData.deleteStudent(current.originalIndex);
                    Get.back();
                  }, child: Text('Delete'))
                ]
              );
            },
            child: Container(
              width: double.infinity,
              color: Color.fromARGB(73, 117, 130, 153),
              child: ListTile(
                leading: CircleAvatar(backgroundImage:  FileImage(File(res.imagePath)),),
                title: Text(res.name),
                trailing: Icon(Icons.arrow_right_alt),
              ),
            )),
      ),
    );
  }
}

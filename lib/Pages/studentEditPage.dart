import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagementgetx/DataBaseFunction/hiveDatasFunction.dart';
import 'package:studentmanagementgetx/Functions/imagePickingFunction.dart';
import 'package:studentmanagementgetx/GetX/getxController.dart';
import 'package:studentmanagementgetx/Model/studentModel.dart';

class StudentEditPage extends StatefulWidget {
  final int index;
  StudentEditPage({super.key, required this.index});

  @override
  State<StudentEditPage> createState() => _StudentEditPageState();
}

class _StudentEditPageState extends State<StudentEditPage> {
      final nameController = TextEditingController();
    final ageController = TextEditingController();
    final rollNoController = TextEditingController();
    final divisionController = TextEditingController();
    XFile? image;
    final studentData = Get.put(studentDataState());
  @override
  void initState() {
    final _current = studentData.allStudentData[widget.index]; 
    nameController.text = _current.name;
    ageController.text = _current.age.toString();
    rollNoController.text = _current.rollNo.toString();
    divisionController.text = _current.division.toString();
    studentData.imgPath = RxString(_current.imagePath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => studentData.imgPath.isNotEmpty
                    ? SizedBox(
                        height: 130,
                        width: 200,
                        child: Image.file(File(studentData.imgPath.toString())),
                      )
                    : Text(studentData.imgPath.toString()),
              ),
              TextButton(
                  onPressed: () async {
                    print('press 1');
                    studentData.imgPath.value = await selectPicture(
                        file: image, imageSource: ImageSource.gallery);
                  },
                  child: Text('Select Image')),
              Text('Name'),
              TextField(
                controller: nameController,
              ),
              Text('Age'),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
              ),
              Text('RollNo'),
              TextField(
                controller: rollNoController,
                keyboardType: TextInputType.number,
              ),
              Text('Division'),
              TextField(
                controller: divisionController,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey)),
                  onPressed: () {
                    if (studentData.imgPath.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        ageController.text.isNotEmpty &&
                        rollNoController.text.isNotEmpty &&
                        divisionController.text.isNotEmpty) {
                      print('press 2');
                      studentModel model = studentModel(name: nameController.text, age: int.parse(ageController.text), rollNo: int.parse(rollNoController.text), division: divisionController.text, imagePath: studentData.imgPath.toString());
                      editFromHive(index: widget.index, model: model);
                      studentData.imgPath = RxString('');
                      studentData.fechData();
                      Get.back();
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

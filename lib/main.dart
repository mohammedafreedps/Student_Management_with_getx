import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentmanagementgetx/Consts/boxes.dart';
import 'package:studentmanagementgetx/Model/studentModel.dart';
import 'package:studentmanagementgetx/Pages/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<studentModel>(studentModelAdapter());
  studentDataListBox = await Hive.openBox<studentModel>('studentDataListBox');
  runApp(const StudentManagement());
}

class StudentManagement extends StatelessWidget {
  const StudentManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
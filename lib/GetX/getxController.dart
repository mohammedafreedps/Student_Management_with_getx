import 'package:get/get.dart';
import 'package:studentmanagementgetx/DataBaseFunction/hiveDatasFunction.dart';
import 'package:studentmanagementgetx/Model/searchModel.dart';
import 'package:studentmanagementgetx/Model/studentModel.dart';

class studentDataState extends GetxController {
  RxList<studentModel> allStudentData = <studentModel>[].obs;
  RxString imgPath = ''.obs;
  RxList<searchResult> searchResults = <searchResult>[].obs;

  void fechData() {
    if (getFromHive().isNotEmpty) {
      allStudentData.assignAll(getFromHive());
      print('jjijij $allStudentData');
      print(allStudentData.length);
      searchAndUpdate('');
    }
  }

  void deleteStudent(int originalIndex){
    deleteFromHive(index: originalIndex);
    allStudentData.removeAt(originalIndex);
    searchAndUpdate('');
  }

  void searchAndUpdate(String query) {
    searchResults.clear();
    if (query.isEmpty) {
      for (var i = 0; i < allStudentData.length; i++) {
        final current = allStudentData[i];
        searchResults
            .add(searchResult(originalIndex: i, studentmodel: current));
      }
    }
    if (query.isNotEmpty) {
      for (var i = 0; i < allStudentData.length; i++) {
        final current = allStudentData[i];
        if (current.name.toLowerCase().contains(query.toLowerCase())) {
          searchResults
              .add(searchResult(originalIndex: i, studentmodel: current));
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fechData();
    searchAndUpdate('');
    print('init callsed ');
  }
}

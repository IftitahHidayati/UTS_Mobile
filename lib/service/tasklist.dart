// TASK LIST ========================================================
import 'package:flutter/material.dart';
 
import '../models/itemvalidation.dart';
import '../models/task.dart';
import 'database_service.dart';
 
class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Task> _taskList = [];
  get taskList => _taskList;
  get taskName => _taskName;
  bool isActive = true;
 
  // String _taskName = "";
  ItemValidation _taskName = ItemValidation(null, null);
 
  // validasi apakah sesuai kriteria
  bool isValidated() {
    return (_taskName.value != null &&
            _taskName.value!.length >= 3 &&
            _taskName.value!.length < 100)
        ? true
        : false;
  }
 
  // validasi inputan berisi pesan error
  void setTaskName(String? taskName) {
    // jika inputan null
    if (taskName == "") {
      _taskName = ItemValidation(null, "Your task name should filled");
      isActive = false;
    } else if (taskName!.length <= 3) {
      // jika inputan kurang dari 3
      _taskName =
          ItemValidation(null, "Task name should be more than 3 character");
      isActive = false;
    } else if (taskName.length >= 100) {
      // jika inputan lebih dari 100
      _taskName =
          ItemValidation(null, "Task name should be less than 100 character");
      isActive = false;
    } else {
      // jika inputan memenuhi kriteria
      _taskName = ItemValidation(taskName, null);
    }
    notifyListeners();
  }
 
  // ketika task name nya berubah
  void whileTaskNameChange(String? value) {
    if (value != "" && 
        value!.length >= 3 && 
        value.length < 100) {
      isActive = true;
    }
    clear();
    notifyListeners();
  }
 
  void clear() {
    _taskName = ItemValidation(null, null);
  }
 
  void changeTaskName(String taskName) {
    _taskName = taskName as ItemValidation;
    notifyListeners();
  }
 
  Future<void> fetchTaskList() async {
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }
 
  Future<void> addTask(String taskName) async {
    await _databaseService.insertTask(
      Task(
        name: taskName,
        status: 0,
      ),
    );
    notifyListeners();
  }
 
  Future<void> deleteTask(Task task) async {
    await _databaseService.deleteTask(task.name);
    fetchTaskList();
    // print("Delete Task ${task.name}");
    notifyListeners();
  }
}
// import 'package:flutter/material.dart';

// import '../models/task.dart';
// import 'database_service.dart';

// class Tasklist with ChangeNotifier {
//   final DatabaseService _databaseService = DatabaseService();

//   List<Task> _taskList = [];
//   String _taskName = "";

//   get taskList => _taskList;
//   get taskName => _taskName;

//   void changeTaskName(String taskName) {
//     _taskName = taskName;
//     notifyListeners();
//   }

//   Future<void> fetchTaskList() async {
//     _taskList = await _databaseService.taskList();
//     notifyListeners();
//   }

//   Future<void> addTask() async {
//     await _databaseService.insertTask(
//       Task(name: _taskName, status: 0),
//     );
//     _taskList = await _databaseService.taskList();
//     notifyListeners();
//   }
//   // final List<Task> _taskList = [];

//   // get taskList => _taskList;

//   // void addNewTask() {
//   //   _taskList.add(
//   //     Task(name: "Task Baru", status: 0),
//   //   );
//   //   notifyListeners();
//   // }
// }

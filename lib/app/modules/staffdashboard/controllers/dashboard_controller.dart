// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:q_and_u_furniture/app/data/models/graph_model.dart';
import 'package:q_and_u_furniture/app/data/services/task_services.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/model/add_task_value.dart';
import 'package:q_and_u_furniture/app/model/task_model.dart';
import 'package:q_and_u_furniture/app/model/user_model.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../widgets/snackbar.dart';

class StaffDashboardController extends GetxController {
  var result = false.obs;
  var taskLoading = false.obs;
  var userLoading = false.obs;
  var taskdata = TaskModel().obs;
  var addTaskValue = AddTaskValuesModel().obs;
  var staffuserdata = StaffUserListModel().obs;
  var graphdata = GraphModel().obs;
  final mapcontroller = Get.put(MapViewController());

  Timer? timer;
  var isTimerRunning = true.obs;

  final title = TextEditingController();
  final discription = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();

  Orders? selectedOrder;
  StaffData? selectedStaff;
  Actionsdata? selectedAction;
  String? selectedPriority;
  String? selectedStatus;

  var timeOfDayMessage = "".obs;

  date() {
    if (DateTime.now().hour >= 0 && DateTime.now().hour < 12) {
      timeOfDayMessage.value = "Morning";
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      timeOfDayMessage.value = "Afternoon";
    } else {
      timeOfDayMessage.value = "Night";
    }
  }

  fetchlocation() {
    if (isTimerRunning.value == false) {
      // If the timer is running, cancel it.
      timer?.cancel();
      isTimerRunning.value = true;

      // isTimerRunning = isTimerRunning;
    } else {
      // If the timer is not running, start it.
      timer = Timer.periodic(const Duration(minutes: 2), (Timer t) {
        postCurrentLocation();

        print("time for 2 min for live location");
      });
      isTimerRunning.value = false;
    }
    // Toggle the timer running state.
  }

  fetchgraph(token) async {
    taskLoading(true);
    var data = await TaskServices().getGraph(token);
    // print("Current lello ${AppStorage.readAccessToken}");

    if (data != null) {
      taskLoading(false);
      // print("graphdata ${data}");
      graphdata.value = GraphModel.fromJson(data);
      // print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  fetchtask(token) async {
    print("helo fetchtask");
    print("Current lello ${AppStorage.readAccessToken}");
    print("token $token");
    taskLoading(true);
    var data =
        await TaskServices().getTask(AppStorage.readAccessToken.toString());
    // print("Current lello ${AppStorage.readAccessToken}");
    print("inside data");

    if (data != null) {
      taskLoading(false);
      print("product12345 $data");
      taskdata.value = TaskModel.fromJson(data);
      print("product value ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  fetctusers(token) async {
    userLoading(true);
    var data = await TaskServices().getusers(token);
    print("Current lello ${AppStorage.readAccessToken}");

    if (data != null) {
      userLoading(false);
      print("product12345 $data");
      staffuserdata.value = StaffUserListModel.fromJson(data);
      print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  fetctAddTaskValue(token) async {
    userLoading(true);
    var data = await TaskServices().getAddTaskValue(token);
    print("Current lello ${AppStorage.readAccessToken}");

    if (data != null) {
      userLoading(false);
      print("product12345 $data");
      addTaskValue.value = AddTaskValuesModel.fromJson(data);
      print("product** ${addTaskValue.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  addTask(
    token,
    var body,
  ) async {
    taskLoading(true);

    // var body = {
    //   "title": taskid,
    //   "description": status,
    //   "status": taskid,
    //   "priority": status,
    //   "start_date": taskid,
    //   "due_date": status,
    //   "action_id": taskid,
    //   "order_id": status,
    //   "assigned_to": status,
    // };
    print("Data Body at controler $body");
    var data = await TaskServices().postTask(token, body);
    print("Current lello ${AppStorage.readAccessToken}");

    if (data != null) {
      taskLoading(false);
      if (data['status'] == 201) {
        Get.back();
        print(data['status']);
      }
      getSnackbar(
        message: "${data['message']}",
        error: false,
      );

      print("product12345 $data");
      // // taskdata.value = TaskModel.fromJson(data);
      // print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  updateATask(token, var body, id) async {
    taskLoading(true);

    // var body = {
    //   "title": taskid,
    //   "description": status,
    //   "status": taskid,
    //   "priority": status,
    //   "start_date": taskid,
    //   "due_date": status,
    //   "action_id": taskid,
    //   "order_id": status,
    //   "assigned_to": status,
    // };
    print("Data Body at controler $body");
    print("Data id at controler $id");
    var data = await TaskServices().updateTask(token, body, id);
    print("Current lello ${AppStorage.readAccessToken}");
    print("data hai : $data");

    if (data != null) {
      taskLoading(false);
      if (data['status'] == 201) {
        Get.back();
        print(data['status']);
      }
      getSnackbar(
        message: "${data['message']}",
        error: false,
      );
      fetchtask(AppStorage.readAccessToken.toString());

      print("product12345 $data");
      // // taskdata.value = TaskModel.fromJson(data);
      // print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  deleteATask(id) async {
    taskLoading(true);

    print("Data id at controler $id");
    var data = await TaskServices()
        .deleteTask(AppStorage.readAccessToken.toString(), id);
    print("Current lello ${AppStorage.readAccessToken}");
    print("data hai : $data");

    if (data != null) {
      taskLoading(false);
      if (data['status'] == 201) {
        Get.back();
        print(data['status']);
      }

      getSnackbar(
        message: "${data['message']}",
        error: false,
      );

      print("product12345 $data");
      // // taskdata.value = TaskModel.fromJson(data);
      // print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  updateTaskstatus(taskid, status) async {
    taskLoading(true);
    var data = await TaskServices().updateTaskStatus(
        AppStorage.readAccessToken.toString(), taskid, status);
    print("Current lello ${AppStorage.readAccessToken}");
    print("data PRint $data");

    if (data != null) {
      taskLoading(false);

      // print("product12345 ${data}");
      // // taskdata.value = TaskModel.fromJson(data);
      // print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  postCurrentLocation() async {
    // taskLoading(true);
    var data = await TaskServices().postlocation(
        AppStorage.readAccessToken.toString(),
        "${mapcontroller.markerPositionLat.value}",
        "${mapcontroller.markerPositionLong.value}");
    print("Current lello ${AppStorage.readAccessToken}");
    print("Location data $data");
    if (data != null) {
      // taskLoading(false);
      // print("product12345 ${data}");
      // // taskdata.value = TaskModel.fromJson(data);
      // print("product** ${taskdata.value}");
    }
    // fetchJustForYouBySlug(justForYouTagsList[0].slug);
    return data;
  }

  checkInternet() async {
    result.value = (await InternetConnectionChecker().hasConnection);
    if (result.value == true) {
    } else {
      getSnackbar(
          bgColor: Colors.red, message: "No internet connection", error: true);
    }
  }
}

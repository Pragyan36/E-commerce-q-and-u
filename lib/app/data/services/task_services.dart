import 'dart:convert';
import 'dart:developer';
import "package:http/http.dart" as http;

import 'package:q_and_u_furniture/app/constants/constants.dart';

class TaskServices {
  Future getTask(token) async {
    try {
      // print("inside api state token $token");
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      print("inside api state");
      // print("Current location ${location}");
      var response = await http.get(Uri.parse("$baseUrl/system/my-tasks"),
          headers: header);
      print("response.body ${response.body}");
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getusers(String token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      // print("Current location ${location}");
      var response =
          await http.get(Uri.parse("$baseUrl/system/users"), headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getAddTaskValue(String token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      // print("Current location ${location}");
      var response = await http.get(
          Uri.parse("$baseUrl/system/get-status-priority"),
          headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future postTask(String token, var body) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      // var body = {"task_id": taskid, "status": status};
      // print("Current location ${location}");
      var response = await http.post(Uri.parse("$baseUrl/system/task"),
          body: body, headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future updateTask(String token, var body, id) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      // var body = {"task_id": taskid, "status": status};
      // print("Current location ${location}");
      var response = await http.put(Uri.parse("$baseUrl/system/task/$id"),
          body: body, headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future deleteTask(String token, id) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      // var body = {"task_id": taskid, "status": status};
      // print("Current location ${location}");
      var response = await http.delete(Uri.parse("$baseUrl/system/task/$id"),
          headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future updateTaskStatus(String token, String taskid, String status) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      var body = {"task_id": taskid, "status": status};
      // print("Current location ${location}");
      var response = await http.post(
          Uri.parse("$baseUrl/system/update-task-status"),
          body: body,
          headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future postlocation(String token, String longitude, String latitude) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {"longitude": longitude, "latitude": latitude};
      // print("Current location ${location}");
      var response = await http.post(
          Uri.parse("$baseUrl/system/current_location"),
          body: body,
          headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future getGraph(String token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      // print("Current location ${location}");
      var response = await http.get(
          Uri.parse("$baseUrl/system/order-status-graph-data"),
          headers: header);
      // log("HomeService:getJustForYou:response:${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

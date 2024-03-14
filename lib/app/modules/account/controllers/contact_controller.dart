import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:q_and_u_furniture/app/data/services/profile_service.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class ContactController extends GetxController {
  var fullname = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var title = TextEditingController();
  var issue = TextEditingController();

  postMsg() async {
    var data = await ProfileService()
        .sendMsg(fullname.text, phone.text, email.text, title.text, issue.text);
    log("ContactController:postMsg:$data");
    if (data != null) {
      if (data['error'] == false) {
        fullname.clear();
        phone.clear();
        email.clear();
        title.clear();
        issue.clear();
        Get.back();
        getSnackbar(message: 'Message Sent Successfully');
      } else {
        getSnackbar(message: 'Error', bgColor: Colors.red, error: true);
      }
    }
  }

  launchCaller(phone) async {
    if (await canLaunchUrl(Uri.parse(phone))) {
      await launchUrl(phone);
    } else {
      throw 'Could not launch $phone';
    }
  }
}

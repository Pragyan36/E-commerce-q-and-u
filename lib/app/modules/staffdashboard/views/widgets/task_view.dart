import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/staffdashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../database/app_storage.dart';
import '../../../../widgets/snackbar.dart';
import '../../../account/controllers/account_controller.dart';

class MyTaskView extends StatefulWidget {
  const MyTaskView({Key? key}) : super(key: key);

  @override
  _MyTaskViewState createState() => _MyTaskViewState();
}

class _MyTaskViewState extends State<MyTaskView> {
  final dashboardcontroller = Get.put(StaffDashboardController());
  final controller = Get.put(AccountController());
  String? selectedValue = "Completed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.white,
              )),
          backgroundColor: AppColor.kalaAppMainColor,
          titleTextStyle: const TextStyle(color: AppColor.white, fontSize: 18),
          title: const Text("My task"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _statusDropdown(),
              dashboardcontroller.taskdata.value.data!.staffTasks!
                      .where(
                          (taskdetail) => taskdetail.status == "$selectedValue")
                      .isEmpty
                  ? Center(child: Text("No task $selectedValue. "))
                  : _list("$selectedValue")
            ],
          ),
        ));
  }

  _statusDropdown() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            items: dashboardcontroller.addTaskValue.value.data!.status!
                .map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
                print("Selected Status: $selectedValue");
              });
            },
            hint: const Text("Completed"),
            isExpanded:
                true, // This ensures the dropdown expands to fill the available space
            icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
            iconSize: 24,
            elevation: 16, // Shadow elevation of the dropdown
            style: const TextStyle(
              color: Colors.black, // Text color
              fontSize: 16,
            ),
            underline: Container(), // Remove the default underline
          ),
        ),
      ),
    );
  }

  _list(title) {
    return Obx(
      () => dashboardcontroller.taskLoading.isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dashboardcontroller.taskdata.value.data!.staffTasks!
                  .where((taskdetail) => taskdetail.status == "$title")
                  .length,
              itemBuilder: (context, index) {
                var taskdetail = dashboardcontroller
                    .taskdata.value.data!.staffTasks!
                    .where((taskdetail) => taskdetail.status == "$title")
                    .toList()[index];
                return dashboardcontroller.taskdata.value.data!.staffTasks!
                        .where((taskdetail) => taskdetail.status == "$title")
                        .isEmpty
                    ? const Center(
                        child: Text("No Task Found"),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            // if (controller
                            //         .staffuserdata.value.data!.roles![0].name ==
                            //     "staff")
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: ((context) => UpdateTask(
                            //             taskData: taskdetail,
                            //           )))
                            // );
                          },
                          child: Container(
                            // width: 200,
                            // height: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        " ${index + 1}. ${taskdetail.title}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: [
                                            TextSpan(
                                                text:
                                                    '${taskdetail.title} ${taskdetail.status} with ${taskdetail.priority} priority.'),
                                            // TextSpan(text: '\n'), // Aaccountdd a line break between the two texts
                                            // TextSpan(
                                            //     text: text2,
                                            //     style:
                                            //         TextStyle(fontWeight: FontWeight.w800)),
                                          ],
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      // RichTextWidget(
                                      //     text1: 'Created By: ',
                                      //     text2: '${taskdetail.createdBy}'),
                                      // SizedBox(height: 10),
                                      // RichTextWidget(
                                      //     text1: 'Created At: ',
                                      //     text2: '${taskdetail.startDate}'),
                                      // SizedBox(height: 10),
                                      // RichTextWidget(
                                      //     text1: 'Status: ', text2: '${taskdetail.status}'),
                                      // SizedBox(height: 10),
                                      // RichTextWidget(
                                      //     text1: 'Action: ',
                                      //     text2: '${taskdetail.action!.title}'),
                                      // SizedBox(height: 10),
                                      // RichTextWidget(
                                      //     text1: 'Priority: ',
                                      //     text2: '${taskdetail.priority}'),
                                    ],
                                  ),
                                ),
                                controller.staffuserdata.value.data!.roles![0]
                                            .name ==
                                        "staff"
                                    ? title != "Completed"
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                width: 140,
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(AppColor
                                                                  .mainClr), // Change the color to your desired background color
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Change Task status of ${taskdetail.title}'),
                                                            content: SizedBox(
                                                              width: double
                                                                  .maxFinite,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount: dashboardcontroller
                                                                    .addTaskValue
                                                                    .value
                                                                    .data!
                                                                    .status!
                                                                    .length, // Replace this with your actual item count
                                                                shrinkWrap:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        i) {
                                                                  return ListTile(
                                                                    title: Text(dashboardcontroller
                                                                        .addTaskValue
                                                                        .value
                                                                        .data!
                                                                        .status![i]),
                                                                    onTap: () {
                                                                      print(
                                                                          "${taskdetail.id}");
                                                                      print(
                                                                          "taped value${dashboardcontroller.addTaskValue.value.data!.status![i]}");
                                                                      // Do something when an item is tapped
                                                                      dashboardcontroller.updateTaskstatus(
                                                                          taskdetail
                                                                              .id
                                                                              .toString(),
                                                                          dashboardcontroller
                                                                              .addTaskValue
                                                                              .value
                                                                              .data!
                                                                              .status![i]);
                                                                      getSnackbar(
                                                                        message:
                                                                            "Status changed successuflly.",
                                                                        error:
                                                                            false,
                                                                      );

                                                                      Navigator.pop(
                                                                          context);

                                                                      dashboardcontroller.fetchtask(AppStorage
                                                                          .readAccessToken
                                                                          .toString());
                                                                      // Close the dialog
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            // actions: [
                                                            //   TextButton(
                                                            //     onPressed: () {
                                                            //       Navigator.pop(
                                                            //           context); // Close the dialog
                                                            //     },
                                                            //     child: Text('Close'),
                                                            //   ),
                                                            // ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: const Text(
                                                        "Update Status")),
                                              ),
                                              // SizedBox(
                                              //   width: 140,
                                              //   child: ElevatedButton(
                                              //       style: ButtonStyle(
                                              //         backgroundColor:
                                              //             MaterialStateProperty
                                              //                 .all<Color>(AppColor
                                              //                     .orange), // Change the color to your desired background color
                                              //       ),
                                              //       onPressed: () {},
                                              //       child: Text("Update Task")),
                                              // ),
                                              // Icon(Icons
                                              //     .arrow_forward_ios_outlined),
                                            ],
                                          )
                                        : const SizedBox()
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
    );
  }
}

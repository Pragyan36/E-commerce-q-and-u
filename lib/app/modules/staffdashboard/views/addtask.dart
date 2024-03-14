import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';
import 'package:q_and_u_furniture/app/model/add_task_value.dart';
import 'package:q_and_u_furniture/app/model/user_model.dart';
import 'package:q_and_u_furniture/app/utils/validators.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class Addtask extends StatefulWidget {
  const Addtask({Key? key}) : super(key: key);

  @override
  _AddtaskState createState() => _AddtaskState();
}

final _formKey = GlobalKey<FormState>();

class _AddtaskState extends State<Addtask> {
  final controller = Get.put(StaffDashboardController());
  DateTime _selectedStartDate =
      DateTime.now(); // Set initial date to 2023-07-28

  Future<void> _selectstartDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: now,
      lastDate: DateTime(
          now.year + 1), // Allow selecting dates up to one year from now
    );

    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  DateTime _selectedEndDate = DateTime.now(); // Set initial date to 2023-07-28

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: now,
      lastDate: DateTime(
          now.year + 1), // Allow selecting dates up to one year from now
    );

    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  @override
  void initState() {
    controller.selectedStaff = null;
    controller.selectedAction = null;
    controller.selectedOrder = null;
    controller.selectedPriority = null;
    controller.selectedStatus = null;
    super.initState();
  }

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
        title: const Text("Add Task"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),

                Text(
                  'Title',
                  style: subtitleStyle,
                ),
                const SizedBox(height: 5),
                MyInputField(
                  labelText: 'Title',
                  controller: controller.title,
                  validator: (v) => validateIsEmpty(string: v),
                ),
                const SizedBox(height: 10),
                Text(
                  'Discription',
                  style: subtitleStyle,
                ),
                const SizedBox(height: 5),
                MyInputField(
                  labelText: 'Discription',
                  controller: controller.discription,
                  validator: (v) => validateIsEmpty(string: v),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Start Date',
                          style: subtitleStyle,
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => _selectstartDate(context),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "${_selectedStartDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'End Date',
                          style: subtitleStyle,
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => _selectEndDate(context),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "${_selectedEndDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // MyInputField(

                //   hint: 'Start Date',
                //   controller: controller.startDate,
                //   inputType: TextInputType.number,
                //   validator: (v) => validateIsEmpty(string: v),
                // ),

                const SizedBox(height: 10),

                _dropdown(),

                const SizedBox(height: 10),
                _orderDropdown(),

                // const SizedBox(height: 10),
                // _dropdown(),
                const SizedBox(height: 10),
                _actionDropdown(),
                // _buildAddress(),
                const SizedBox(height: 10),
                _priorityDropdown(),
                const SizedBox(height: 10),
                _statusDropdown(),

                /*Text(
                                                  'Area',
                                                  style: subtitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                MyInputField(
                                                  hint: 'Area',
                                                  controller: controller.area,
                                                ),*/
                /*const SizedBox(height: 10),
                                                Text(
                                                  'Country',
                                                  style: subtitleStyle,
                                                ),
                                                const SizedBox(height: 5),
                                                MyInputField(
                                                  hint: 'Country',
                                                  controller: controller.country,
                                                ),*/

                const SizedBox(height: 20),
                Obx(
                  () => Center(
                    child: controller.taskLoading.isTrue
                        ? const CircularProgressIndicator(
                            color: AppColor.kalaAppMainColor,
                          )
                        : CustomButtons(
                            width: double.infinity,
                            label: 'Add Task',
                            btnClr: AppColor.kalaAppMainColor,
                            txtClr: Colors.white,
                            ontap: () async {
                              if (!_formKey.currentState!.validate()) {
                                getSnackbar(
                                  message: "Please fill form correctly",
                                  error: true,
                                  bgColor: Colors.red,
                                );
                                return;
                              }
                              controller.addTask(
                                "${AppStorage.readAccessToken}",
                                {
                                  "title": controller.title.text.toString(),
                                  "description":
                                      controller.discription.text.toString(),
                                  "status":
                                      controller.selectedStatus.toString(),
                                  "priority":
                                      controller.selectedPriority.toString(),
                                  "start_date":
                                      "${_selectedStartDate.toLocal()}"
                                          .split(' ')[0],
                                  "due_date": "${_selectedEndDate.toLocal()}"
                                      .split(' ')[0],
                                  "action_id":
                                      controller.selectedAction!.id.toString(),
                                  "order_id": controller.selectedOrder == null
                                      ? ""
                                      : controller.selectedOrder!.id.toString(),
                                  "assigned_to":
                                      controller.selectedStaff!.id.toString(),
                                },
                              );

                              // controller.updateUser();
                            },
                          ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx _statusDropdown() {
    return Obx(
      () => DropdownButtonFormField2<String>(
        value: controller.selectedStatus,
        items: controller.addTaskValue.value.data!.status!.map((String status) {
          return DropdownMenuItem<String>(
            value: status,
            child: Text(status),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select Status.';
          }
          return null;
        },
        onChanged: (String? newValue) {
          setState(() {
            controller.selectedStatus = newValue;
            print("Selected Status: $controller.selectedStatus");
          });
        },
        hint: controller.selectedStatus == null
            ? const Text("Select Status")
            : null,
        isExpanded:
            true, // This ensures the dropdown expands to fill the available space
        icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
        iconSize: 24,
        // elevation: 16, // Shadow elevation of the dropdown
        style: const TextStyle(
          color: Colors.black, // Text color
          fontSize: 16,
        ),
        // underline: Container(), // Remove the default underline
      ),
    );
  }

  Obx _priorityDropdown() {
    return Obx(
      () => DropdownButtonFormField2<String>(
        value: controller.selectedPriority,
        items: controller.addTaskValue.value.data!.priority!
            .map((String priority) {
          return DropdownMenuItem<String>(
            value: priority,
            child: Text(priority),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select Priority.';
          }
          return null;
        },
        onChanged: (String? newValue) {
          setState(() {
            controller.selectedPriority = newValue;
            print("Selected Priority: $controller.selectedPriority");
          });
        },
        hint: controller.selectedPriority == null
            ? const Text("Select Priority")
            : null,
        isExpanded:
            true, // This ensures the dropdown expands to fill the available space
        icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
        iconSize: 24,
        // elevation: 16, // Shadow elevation of the dropdown
        style: const TextStyle(
          color: Colors.black, // Text color
          fontSize: 16,
        ),
        // underline: Container(), // Remove the default underline
      ),
    );
  }

  Obx _actionDropdown() {
    return Obx(
      () => DropdownButtonFormField2<Actionsdata>(
        value: controller.selectedAction,
        items: controller.addTaskValue.value.data!.actions!
            .map((Actionsdata action) {
          return DropdownMenuItem<Actionsdata>(
            value: action,
            child: Text("${action.title}"),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select Action.';
          }
          return null;
        },
        onChanged: (Actionsdata? newValue) {
          setState(() {
            controller.selectedAction = newValue;
            print("selectedOrder${controller.selectedAction}");
          });
        },
        hint: controller.selectedAction == null
            ? const Text("Select Action")
            : null,
        isExpanded:
            true, // This ensures the dropdown expands to fill the available space
        icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
        iconSize: 24,
        // elevation: 16, // Shadow elevation of the dropdown
        style: const TextStyle(
          color: Colors.black, // Text color
          fontSize: 16,
        ),
        // underline: Container(), // Remove the default underline
      ),
    );
  }

  _orderDropdown() {
    return Obx(
      () => DropdownButtonFormField2<Orders>(
        value: controller.selectedOrder,
        items: controller.addTaskValue.value.data!.orders!.map((Orders order) {
          return DropdownMenuItem<Orders>(
            value: order,
            child: Text("${order.refId}"),
          );
        }).toList(),
        //  validator: (value) {
        //     if (value == null) {
        //       return 'Please select Order.';
        //     }
        //   },
        onChanged: (Orders? newValue) {
          setState(() {
            controller.selectedOrder = newValue;
            print("selectedOrder${controller.selectedOrder}");
          });
        },
        hint: controller.selectedOrder == null
            ? const Text("Select Orders")
            : null,
        isExpanded:
            true, // This ensures the dropdown expands to fill the available space
        icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
        iconSize: 24,
        // elevation: 16, // Shadow elevation of the dropdown
        style: const TextStyle(
          color: Colors.black, // Text color
          fontSize: 16,
        ),
        // underline: Container(), // Remove the default underline
      ),
    );
  }

  _dropdown() {
    return Obx(
      () => DropdownButtonFormField2<StaffData>(
        value: controller.selectedStaff,
        items: controller.staffuserdata.value.data!.map((StaffData staff) {
          return DropdownMenuItem<StaffData>(
            value: staff,
            child: Text("${staff.name}"),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select Staff.';
          }
          return null;
        },
        onChanged: (StaffData? newValue) {
          setState(() {
            controller.selectedStaff = newValue;
            print("selectedOrder${controller.selectedOrder}");
          });
        },
        hint: controller.selectedStaff == null
            ? const Text("Select Staff")
            : null,
        isExpanded:
            true, // This ensures the dropdown expands to fill the available space
        icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
        iconSize: 24,
        // elevation: 16, // Shadow elevation of the dropdown
        style: const TextStyle(
          color: Colors.black, // Text color
          fontSize: 16,
        ),
        // underline: Container(), // Remove the default underline
      ),
    );
  }
}

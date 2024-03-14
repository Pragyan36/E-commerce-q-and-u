import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/model/return_order_view.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';

class ApplyRefundScreen extends StatefulWidget {
  ApplyRefundScreen({super.key, required this.returnOrderViewHeadingModel});
  ReturnOrderViewHeadingModel returnOrderViewHeadingModel;
  @override
  State<ApplyRefundScreen> createState() => _ApplyRefundScreenState();
}

class _ApplyRefundScreenState extends State<ApplyRefundScreen> {
  int? applyRefund;
  bool showEsewaData = false;
  bool showKhaltiData = false;
  bool showBankData = false;
  String dropdownvalue = '--Choose Account Type--';

  var items = [
    '--Choose Account Type--',
    'Current Account',
    'Saving Account',
  ];
  final esewaUserNameController = TextEditingController();
  final esewaIDController = TextEditingController();
  final esewaContactController = TextEditingController();
  final khaltiUserNameController = TextEditingController();
  final khaltiIdController = TextEditingController();
  final khaltiContactNumberController = TextEditingController();
  final bankUserNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankBranchController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final bankContactNumberController = TextEditingController();
  final controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Apply for Refund',
        trailing: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile(
              title: const Text("Cash"),
              value: 1,
              groupValue: applyRefund,
              onChanged: (value) {
                setSelectedRadioTile(1);
                setState(() {
                  showEsewaData = false;
                  showKhaltiData = false;
                  showBankData = false;
                });
              },
            ),
            RadioListTile(
              title: const Text("Esewa"),
              value: 2,
              groupValue: applyRefund,
              onChanged: (value) {
                setSelectedRadioTile(2);
                setState(() {
                  showEsewaData = true;
                  showKhaltiData = false;
                  showBankData = false;
                });
              },
            ),
            showEsewaData
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeading('User Name'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: esewaUserNameController,
                          hintText: 'Enter Eesewa Name here ....',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomHeading('Esewa ID'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: esewaIDController,
                          hintText: 'Enter Eesewa ID  here ....',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomHeading('Contact Number'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: esewaContactController,
                          hintText: 'Enter Contact Number here ....',
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            RadioListTile(
              title: const Text("Khalti"),
              value: 3,
              groupValue: applyRefund,
              onChanged: (value) {
                setSelectedRadioTile(3);
                setState(() {
                  showKhaltiData = true;
                  showEsewaData = false;
                  showBankData = false;
                });
              },
            ),
            showKhaltiData
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeading('User Name'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: khaltiUserNameController,
                          hintText: 'Enter Khalti Name here ....',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomHeading('Khalti ID'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: khaltiIdController,
                          hintText: 'Enter Khalti ID  here ....',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomHeading('Contact Number'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: khaltiContactNumberController,
                          hintText: 'Enter Contact Number here ....',
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            RadioListTile(
              title: const Text("Bank"),
              value: 4,
              groupValue: applyRefund,
              onChanged: (value) {
                setSelectedRadioTile(4);
                setState(() {
                  showBankData = true;
                  showEsewaData = false;
                  showKhaltiData = false;
                });
              },
            ),
            showBankData
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomHeading('Account Holder Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            controller: bankUserNameController,
                            hintText: 'Enter Account Name here ....',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomHeading('Bank Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            controller: bankNameController,
                            hintText: 'Enter Bank Name  here ....',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomHeading('Branch'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            controller: bankBranchController,
                            hintText: 'Enter Branch here ....',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomHeading('Account Number'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            controller: bankAccountNumberController,
                            hintText: 'Enter Valid Account Number here ....',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomHeading('Contact Number'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            controller: bankContactNumberController,
                            hintText: 'Enter Contact Number here ....',
                          ),
                          DropdownButtonFormField2(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 70.0, left: 10, right: 10),
        child: Row(
          children: [
            Expanded(
              child: CustomButtons(
                label: 'Reset',
                btnClr: Colors.red,
                txtClr: Colors.white,
                ontap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButtons(
                label: 'Apply',
                btnClr: Colors.blue,
                txtClr: Colors.white,
                ontap: () {
                  controller.cashRefund(
                      widget.returnOrderViewHeadingModel.id.toString(),
                      context);
                  controller.esewaApplyRefund(
                      esewaUserNameController.text,
                      esewaContactController.text,
                      esewaIDController.text,
                      widget.returnOrderViewHeadingModel.id.toString(),
                      context);
                  controller.khaltiApplyRefund(
                      khaltiUserNameController.text,
                      khaltiIdController.text,
                      khaltiContactNumberController.text,
                      widget.returnOrderViewHeadingModel.id.toString(),
                      context);

                  controller.bankApplyRefund(
                      bankUserNameController.text,
                      bankNameController.text,
                      bankBranchController.text,
                      bankAccountNumberController.text,
                      bankContactNumberController.text,
                      dropdownvalue,
                      widget.returnOrderViewHeadingModel.id.toString(),
                      context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Text CustomHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 17, color: Colors.black54, fontWeight: FontWeight.bold),
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      applyRefund = val;
    });
  }
}

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: hintText,
          border: const OutlineInputBorder()),
    );
  }
}

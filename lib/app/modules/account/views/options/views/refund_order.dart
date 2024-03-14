import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/my_order.dart';
import 'package:q_and_u_furniture/app/modules/account/views/options/views/apply_refund.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';

class RefundOrder extends StatefulWidget {
  final String orderId;

  const RefundOrder({
    super.key,
    required this.orderId,
  });

  @override
  State<RefundOrder> createState() => _RefundOrderState();
}

class _RefundOrderState extends State<RefundOrder> {
  final OrderController controller = Get.put(
    OrderController(),
  );
  TextEditingController userName = TextEditingController();
  TextEditingController userID = TextEditingController();
  TextEditingController userContact = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController accountType = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  final List<Map> paymentTypes = [
    {
      'name': 'Cash',
      'id': 3,
      'icon': const AssetImage("assets/images/payment-method.png"),
      'subtitle': 'Refund by Debit Cash on Delivery'
    },
    {
      'name': 'Esewa',
      'id': 2,
      'icon': const AssetImage("assets/images/Esewa.png"),
      'subtitle': 'Refund by Esewa'
    },
    {
      'name': 'Khalti',
      'id': 1,
      'icon': const AssetImage("assets/images/Khalti.png"),
      'subtitle': 'Refund by Khalti'
    },
    {
      'name': 'Bank',
      'id': 4,
      'icon': const AssetImage("assets/images/payment-method.png"),
      'subtitle': 'Refund by Bank'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Refund order'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              paymentTypes.length,
              (index) => GetBuilder<OrderController>(
                builder: (_) {
                  return RadioListTile(
                    title: Text(
                      paymentTypes[index]['name'],
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      paymentTypes[index]['subtitle'],
                      style: subtitleStyle.copyWith(color: Colors.grey),
                    ),
                    secondary: Image(
                      image: paymentTypes[index]['icon'],
                      height: 20,
                      width: 20,
                    ),
                    value: paymentTypes[index]['id'].toString(),
                    groupValue: controller.select,
                    onChanged: (val) {
                      setState(() {
                        controller.setSelectedRadio(val);
                        controller.selected.value = int.parse(
                          val.toString(),
                        );
                      });
                    },
                  );
                },
              ),
            ),
            controller.selected.value == 2
                ? esewaTextField()
                : const SizedBox(),
            controller.selected.value == 1
                ? khaltiTextField()
                : const SizedBox(),
            controller.selected.value == 4 ? bankTextField() : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            CustomButtons(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              label: 'Apply for Refund',
              btnClr: AppColor.kalaAppMainColor,
              txtClr: Colors.white,
              ontap: () async {
                String returnType = controller.selected.value == 2
                    ? "esewa"
                    : controller.selected.value == 1
                        ? "khalti"
                        : controller.selected.value == 4
                            ? "bank"
                            : "cash";
                controller
                    .applyrefund(
                        widget.orderId,
                        userName.text,
                        returnType,
                        bankName.text,
                        branchName.text,
                        accountNumber.text,
                        userID.text,
                        userContact.text,
                        accountType.text)
                    .then(
                  (value) {
                    if (value != null) {
                      const snackBar = SnackBar(
                        content: Text('Applied Sucessfully'),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.to(
                        const MyOrderView(
                          isFromPurchaseView: false,
                        ),
                      );
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Applied failed'),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    debugPrint("value is$value");
                  },
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  esewaTextField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              CustomTextfield(controller: userName, hintText: "Esewa Username"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(controller: userID, hintText: "Esewa ID"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(controller: userContact, hintText: "Contact"),
        ),
      ],
    );
  }

  khaltiTextField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(
              controller: userName, hintText: "Khalti Username"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(controller: userID, hintText: "Khalti ID"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(controller: userContact, hintText: "Contact"),
        ),
      ],
    );
  }

  bankTextField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(
              controller: userName, hintText: "Account Holder Username"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(controller: bankName, hintText: "Bank Name"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(
              controller: accountNumber, hintText: "Account Number"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              CustomTextfield(controller: branchName, hintText: "Branch Name"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(controller: userContact, hintText: "Contact"),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomTextfield(
              controller: accountType, hintText: "Account Type"),
        ),
      ],
    );
  }
}

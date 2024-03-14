import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_button.dart';
import 'package:q_and_u_furniture/app/widgets/inputfield.dart';

class AddNewCardView extends StatefulWidget {
  const AddNewCardView({Key? key}) : super(key: key);

  @override
  State<AddNewCardView> createState() => _AddNewCardViewState();
}

class _AddNewCardViewState extends State<AddNewCardView> {
  String dropdownvalue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Add New Address'),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            _buildFormTile('First Name'),
            _buildFormTile('Last Name'),
            _buildFormTile('Address'),
            _buildFormTile('City'),
            _buildFormTile('Postal Code'),
            _buildFormTile('Country'),
            _buildFormTile('Phone Number'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
            label: "Save & Continue",
            btnClr: AppColor.kalaAppMainColor,
            txtClr: Colors.white,
            ontap: () {}),
      ),
    );
  }

  _buildFormTile(label) {
    return ListTile(
      title: Text(
        label,
        style: subtitleStyle,
      ),
      subtitle: const MyInputField(labelText: ''),
    );
  }

  buildDropDown(List<String> items) {
    return DropdownButton(
      icon: const Icon(Icons.keyboard_arrow_down),
      value: dropdownvalue,
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}

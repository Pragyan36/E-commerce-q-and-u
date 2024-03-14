import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Notification Settings'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(
                value: false,
                title: Text(
                  'Enable Notification',
                  style: subtitleStyle,
                ),
                onChanged: (val) {})
          ],
        ),
      ),
    );
  }
}

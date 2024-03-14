import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods({
    super.key,
  });

  final List<Map> paymentTypes = [
    {'name': 'Mastercard', 'id': 0, 'icon': Iconsax.card},
    {'name': 'Apple Pay', 'id': 1, 'icon': Icons.apple},
    {'name': 'Paypal', 'id': 2, 'icon': Iconsax.play},
    {'name': 'American Express', 'id': 3, 'icon': Iconsax.ticket_expired},
    {'name': 'Visa', 'id': 4, 'icon': Icons.credit_card},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Payment Methods'),
      body: Column(
        children: [
          ...List.generate(
            paymentTypes.length,
            (index) => ListTile(
              title: Text(
                paymentTypes[index]['name'],
                style: titleStyle,
              ),
              leading: Icon(
                paymentTypes[index]['icon'],
                size: 30,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              '+ Add new card',
              style: titleStyle,
            ),
          ),
        ],
      ),
    );
  }
}

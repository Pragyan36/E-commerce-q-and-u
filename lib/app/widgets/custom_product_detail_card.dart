import 'package:flutter/material.dart';

class CustomProductDetailCard extends StatelessWidget {
  final Widget child;

  const CustomProductDetailCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

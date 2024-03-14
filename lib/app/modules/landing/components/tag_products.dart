import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/modules/landing/components/homebody.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';

class TagProducts extends StatefulWidget {
  final String name;
  
  const TagProducts({
    super.key,
    required this.name,
  });

  @override
  State<TagProducts> createState() => _TagProductsState();
}

class _TagProductsState extends State<TagProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.name,
      ),
      body: const HomeBody(),
    );
  }
}

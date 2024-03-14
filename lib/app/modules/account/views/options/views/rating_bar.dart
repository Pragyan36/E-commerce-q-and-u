// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rat;

class RatingBarScreen extends StatefulWidget {
  RatingBarScreen({super.key, required this.value});
  double value;
  @override
  State<RatingBarScreen> createState() => _RatingBarScreenState();
}

class _RatingBarScreenState extends State<RatingBarScreen> {
  @override
  Widget build(BuildContext context) {
    return rat.RatingBar.builder(
      initialRating: widget.value,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      updateOnDrag: true,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      onRatingUpdate: (value) {
        setState(() {
          widget.value = value;
        });
      },
    );
  }
}

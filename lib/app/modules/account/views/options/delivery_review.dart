// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rat;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_and_u_furniture/app/modules/account/controllers/order_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:q_and_u_furniture/app/widgets/custom_buttons.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class DeliveryReviewView extends StatefulWidget {
  const DeliveryReviewView({super.key, required this.orderId});

  final int orderId;

  @override
  State<DeliveryReviewView> createState() => _DeliveryReviewViewState();
}

class _DeliveryReviewViewState extends State<DeliveryReviewView> {
  var additionalTextEditingController = TextEditingController();
  int? gender;
  final _formKey = GlobalKey<FormState>();
  final imageKey = GlobalKey<FormState>();
  bool addReview = false;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImage = await imagePicker.pickMultiImage();
    if (selectedImage.isNotEmpty) {
      imageFileList.addAll(selectedImage);
    }
    setState(() {});
  }

  double ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Reviews To Delivery',
        trailing: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Review and Ratings',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Your Ratings',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              rat.RatingBar.builder(
                initialRating: ratingValue,
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
                    ratingValue = value;
                  });
                },
              ),
              // RatingBarScreen(
              //     value: ratingValue != null ? ratingValue!.toDouble() : 0),
              const SizedBox(
                height: 10,
              ),
              // if (addReview)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4),
              //     child: Text(
              //       'Please add Your Rating',
              //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //             color: Colors.red,
              //           ),
              //     ),
              //   ),
              const Text(
                'Your Review',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 8,
                minLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add Your review';
                  }
                  return null;
                },
                controller: additionalTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Write Something',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: !addReview
                        ? 'Upload Multiple Images'
                        : 'Please add an Image',
                    style: TextStyle(
                      color: !addReview ? Colors.grey : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    children: const [
                      TextSpan(
                        text: '( less than 2MB/Image )',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  selectImages();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Choose File',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // if (addReview)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4),
              //     child: Text(
              //       'Please upload Image',
              //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //             color: Colors.red,
              //           ),
              //     ),
              //   ),
              const SizedBox(
                height: 10,
              ),
              imageFileList.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: imageFileList.length,
                          // physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                File(imageFileList[index].path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            );
                          }),
                    )
                  : const SizedBox(),

              if (addReview)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Please upload Image',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   'Your Response',
                    //   style: TextStyle(
                    //     color: Colors.black54,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // RadioListTile(
                    //   title: const Text("Positive"),
                    //   value: 1,
                    //   groupValue: gender,
                    //   onChanged: (value) {
                    //     setSelectedRadioTile(1);
                    //   },
                    // ),
                    // RadioListTile(
                    //   title: const Text("Netural"),
                    //   value: 2,
                    //   groupValue: gender,
                    //   onChanged: (value) {
                    //     setSelectedRadioTile(2);
                    //   },
                    // ),
                    // RadioListTile(
                    //   title: const Text("Negative"),
                    //   value: 3,
                    //   groupValue: gender,
                    //   onChanged: (value) {
                    //     setSelectedRadioTile(3);
                    //   },
                    // ),
                    // if (addReview)
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 4),
                    //     child: Text(
                    //       'Please add Your Response',
                    //       style:
                    //           Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //                 color: Colors.red,
                    //               ),
                    //     ),
                    //   ),
                    CustomButtons(
                        width: double.infinity,
                        label: 'Save',
                        btnClr: Colors.red,
                        txtClr: Colors.white,
                        ontap: () {
                          if (ratingValue.isZero) {
                            getSnackbar(
                                message: 'Please select an rating',
                                bgColor: Colors.red,
                                error: true);
                          } else {
                            if (_formKey.currentState!.validate()) {
                              controller.loading.value
                                  ? null
                                  : controller
                                      .addReviewfordelivery(
                                          widget.orderId.toString(),
                                          ratingValue.toInt().toString(),
                                          additionalTextEditingController.text,
                                          imageFileList)
                                      .then((value) {
                                      Navigator.pop(context);
                                      additionalTextEditingController.text = '';
                                      imageFileList.clear();
                                    });
                            }
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      gender = val;
    });
  }
}

class RatingBar extends StatefulWidget {
  final int starCount;
  double rating;
  final Color? color;
  final double? size;

  RatingBar(
      {super.key,
      this.starCount = 5,
      this.rating = 0.0,
      this.color,
      this.size});

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.rating = index + 1.0;
            });
          },
          child: Icon(
            Icons.star,
            size: widget.size,
            color: index < widget.rating ? widget.color : Colors.black38,
          ),
        );
      }),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/data/models/home_model.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';

class ImageSliderWidget extends StatefulWidget {
  List<Sliders> sliderImage = [];

  ImageSliderWidget({
    Key? key,
    required this.sliderImage,
  }) : super(key: key);

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _imageCurrentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final homeController = Get.put(
    HomeController(),
  );

  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        if (_imageCurrentIndex < widget.sliderImage.length - 1) {
          _imageCurrentIndex++;
        } else {
          _imageCurrentIndex = 0;
        }
        // _pageController.animateToPage(
        //   _imageCurrentIndex,
        //   duration: const Duration(milliseconds: 500),
        //   curve: Curves.ease,
        // );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return imagesList(widget.sliderImage);
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.sliderImage.length; i++) {
      list.add(i == _imageCurrentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColor.mainClr : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget imagesList(List<Sliders> sliderImage) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.sliderImage.length,
        itemBuilder: (BuildContext context, int index) {
          var data = sliderImage[index];
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: GestureDetector(
                onTap: () {
                  // if (data.id == 7) {
                  //   homeController.makeUrl(data.link.toString());
                  // } else {
                  //   var splitData = data.link.toString();
                  //   var split = splitData.split('/').last;
                  //   if (kDebugMode) {
                  //     print(split);
                  //   }
                  //   Get.to(() => ProductDetailView(
                  //         productname: data.title,
                  //         productprice: data.id.toString(),
                  //         slug: split,
                  //         productid: data.id,
                  //       ));
                  // }
                },
                child: CachedNetworkImage(
                  imageUrl: data.altImage != null
                      ? data.altImage!
                          .replaceAll(RegExp(r'http://127.0.0.1:8000'), url)
                      : '',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade300),
                        padding: const EdgeInsets.all(50),
                        child: Image.asset("assets/images/Placeholder.png"),
                      )),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/Placeholder.png",
                    height: 70,
                  ),
                ),
              ),
            ),
          );
        },
        onPageChanged: (int index) {
          setState(() {
            _imageCurrentIndex = index;
          });
        },
      ),
    );
  }

  Widget sliderImageContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator(),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  Future<void> showDialog({
    String? title,
    Widget? header,
    String? subtitle,
    required BuildContext context,
    List<Widget>? actions,
  }) {
    return Get.defaultDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.symmetric(horizontal: 20),
      title: '',
      content: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Wrap(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: const Color(0xff231F20))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              subtitle ?? '',
                              // maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                      color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: buttonHeight ?? 20),

                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: actions ?? [],
                      )
                    ],
                  ),
                ),

                //For displaying the emoji
              ],
            ),
          ],
        ),
      ),
    );
  }
}

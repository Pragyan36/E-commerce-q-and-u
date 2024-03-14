import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_and_u_furniture/app/modules/home/controllers/home_controller.dart';
import 'package:q_and_u_furniture/app/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsView extends GetView {
  const TermsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(
      HomeController(),
    );
    homeController.fetchPrivacyPolicy();
    const String termsAndConditionsUrl =
        "https://qandufurniture.com/terms-and-conditions";

    WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..enableZoom(true)
      ..loadRequest(
        Uri.parse(termsAndConditionsUrl),
      );

    return Scaffold(
      appBar: CustomAppbar(
        title: "Terms and Conditions",
        trailing: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        child: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}

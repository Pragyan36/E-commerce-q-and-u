import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/modules/landing/controllers/landing_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/controllers/search_controller.dart';
import 'package:q_and_u_furniture/app/modules/search/views/qr_scanner.dart';
import 'package:q_and_u_furniture/app/modules/search/views/search_items.dart';
import 'package:q_and_u_furniture/app/modules/search/views/suggestion_page.dart';
import 'package:q_and_u_furniture/app/widgets/nodata.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final CustomSearchController controller = Get.put(
    CustomSearchController(),
  );
  final LandingController landingcontroller = Get.put(
    LandingController(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.searchList.clear();
    });
    super.initState();
  }

  @override
  void dispose() {
    landingcontroller.page.value = 1;
    controller.searchtxt.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchAttributes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
          onTap: () {
            controller.searchtxt.clear();
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(50),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 80.w,
              height: 40,
              child: Obx(
                () => TextField(
                  controller: controller.searchtxt,
                  onChanged: (s) {
                    if (s.endsWith(' ')) {
                      controller.fetchSearch();
                      controller.currentSearch.value = '';
                    } else {
                      controller.currentSearch.value = s;
                    }
                  },
                  textInputAction: TextInputAction.search,
                  onSubmitted: (val) {
                    if (controller.currentSearch.value.isNotEmpty) {
                      controller.fetchSearch();
                      controller.currentSearch.value = '';
                    }
                    Get.to(
                      () => const SearchItems(),
                    );
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    hintText: 'Search...',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColor.kalaAppAccentColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColor.kalaAppMainColor,
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.to(
                              () => const QrScannerVIew(),
                            );
                          },
                          icon: const Icon(
                            Iconsax.scan_barcode,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            controller.listen();
                          },
                          icon: Icon(
                            controller.isListening.value
                                ? Icons.settings_voice_outlined
                                : Icons.keyboard_voice_outlined,
                            color: controller.isListening.value
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => controller.searchList.isNotEmpty
                    ? const SuggestionList()
                    : const NoDataView(
                        text: "No search result",
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

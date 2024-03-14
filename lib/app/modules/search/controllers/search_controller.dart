// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_scanner/src/types/barcode.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:q_and_u_furniture/app/data/models/attribute_model.dart';
import 'package:q_and_u_furniture/app/data/models/brand_model.dart';
import 'package:q_and_u_furniture/app/data/models/search_model.dart';
import 'package:q_and_u_furniture/app/data/services/filter_service.dart';
import 'package:q_and_u_furniture/app/data/services/search_service.dart';
import 'package:q_and_u_furniture/app/widgets/snackbar.dart';

class CustomSearchController extends GetxController {
  var selectedindex = 0.obs;
  var currentSearch = ''.obs;
  var isListening = false.obs;
  var speechText = 'text'.obs;
  var initSearch = false.obs;
  var searchList = <SearchModelData>[].obs;
  var attributesList = <AttributeData>[].obs;
  late SpeechToText speechToText;
  var isListview = false.obs;
  var recentserches = <String>[].obs;
  var box = GetStorage().obs;

  var items = ['Product', 'Brands'];
  var sort = ['High to low', 'Low to high'];

  var dropDownVal = 'select'.obs;
  var dropDownVal1 = 'select'.obs;
  TextEditingController searchtxt = TextEditingController();

  @override
  void onInit() {
    fetchAttributes();
    dropDownVal.value = items[0];
    dropDownVal1.value = sort[0];
    speechToText = SpeechToText();
    if (box.value.read('recent') == null) {
      box.value.write('recent', recentserches);
    }
    super.onInit();
  }

  void qr(Barcode? result) async {
    searchtxt.text = result!.code.toString();
    debugPrint(result.code);
  }

  void listen() async {
    bool available = await speechToText.initialize(
      onStatus: (val) {
        if (val == 'notListening') {
          isListening.value = false;
          log(isListening.value.toString(), name: "Is Listening");
        }
      },
      onError: (val) {},
      finalTimeout: const Duration(seconds: 10),
    );
    if (available) {
      isListening.value = true;
      speechToText.listen(
        onResult: (val) {
          searchtxt.text = val.recognizedWords;
          if (val.recognizedWords.isNotEmpty) {
            fetchSearch();
          }
        },
      );
      log(isListening.value.toString(), name: "Is Listening");
    } else {
      isListening.value = false;
    }
  }

  fetchSearch() async {
    var data = await SearchService().getSearch(searchtxt.text);
    recentserches.add(searchtxt.text);
    debugPrint("new searched name ${searchtxt.text}");
    box.value.write('recent', recentserches);

    if (data != null) {
      debugPrint("added search $data");
      if (data['error'] == false) {
        searchList.clear();
        data['data']
            .forEach((v) => searchList.add(SearchModelData.fromJson(v)));
      } else {
        getSnackbar(message: 'no product', error: true);
      }
    } else {}
  }

  var brandList = <Brands>[].obs;

  fetchAttributes() async {
    var data = await FilterService().getAttributes();
    if (data != null) {
      if (data['error'] == false) {
        attributesList.clear();
        brandList.clear();
        data['data']['brands'].forEach(
          (v) => brandList.add(
            Brands.fromJson(v),
          ),
        );
      }
    } else {}
  }

  var brandproductList = <BrandData>[].obs;
  var isLoading = false.obs;

  fetchBrandById(id) async {
    isLoading(true);
    var data = await FilterService().getBrandbyId(id);
    debugPrint(data.toString());
    if (data != null) {
      isLoading(false);

      if (data['error'] == false) {
        brandproductList.clear();
        data['data']
            .forEach((v) => brandproductList.add(BrandData.fromJson(v)));
      }
    } else {}
  }
}

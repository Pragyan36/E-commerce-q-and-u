import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:q_and_u_furniture/app/constants/constants.dart';
import 'package:q_and_u_furniture/app/database/app_storage.dart';

class OrderService {
  Future getUserOrder(token) async {
    log("token is $token");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var response = await http.get(
        Uri.parse(
          '$baseUrl/user-order',
        ),
        headers: header);
    if (kDebugMode) {
      debugPrint(response.body);
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint("order list $data");
      return data;
    } else {}
  }

  Future getLocationTrack(token, email, refId) async {
    log("getLocation:body:$email");
    log("getLocation:body:$refId");
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    var response = await http.get(
        Uri.parse(
          '$baseUrl/track-order?email=$email&refId=$refId',
        ),
        headers: header);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('throw an exception');
    }
  }

  Future applyRefund(
      token,
      String orderID,
      String username,
      String returnType,
      String bankName,
      String branch,
      String accountNumber,
      String userID,
      String contactNumber,
      String accountType) async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = {
      "return_type": returnType,
      "order_id": orderID,
      "name": username,
      "payment_method": bankName,
      "branch": branch,
      "wallet_id": userID,
      "acc_no": accountNumber,
      "contact_no": contactNumber,
      "account_type": accountType,
    };
    debugPrint("body of refund is $body");
    var response = await http.post(
        Uri.parse(
          '$baseUrl/refund-direct-apply',
        ),
        headers: header,
        body: body);
    debugPrint(response.statusCode.toString());
    if (kDebugMode) {
      debugPrint(response.toString());
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('throw an exception');
    }
  }

  Future cancelOrder(
    token,
    orderId,
    reason,
    additionalreason,
    aggressive,
  ) async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = {
      "order_id": orderId,
      "reason": reason,
      "additional_reason": additionalreason,
      "aggree": aggressive,
    };
    var response = await http.post(
        Uri.parse(
          '$baseUrl/cancel-order',
        ),
        headers: header,
        body: body);
    if (kDebugMode) {
      debugPrint(response.toString());
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('throw an exception');
    }
  }

  Future getAllReview(token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.get(
        Uri.parse(
          '$baseUrl/getReview',
        ),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data["data"];
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'getAllReview Error');
    }
  }

  Future addReview({
    String? token,
    String? productId,
    String? rating,
    String? message,
    required List<File> files,
    int? responses,
  }) async {
    try {
      //  var header = {
      //     "Accept": "application/json",
      //     "Authorization": "Bearer $token"
      //   };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$baseUrl/add-review',
        ),
      );
      request.headers['Authorization'] = 'Bearer ${AppStorage.readAccessToken}';
      request.fields['product_id'] = productId!;
      request.fields['rating'] = rating!;
      request.fields['message'] = message!;
      request.fields['response'] = responses.toString();

      for (var i = 0; i < files.length; i++) {
        var file = await http.MultipartFile.fromPath('image[]', files[i].path);
        request.files.add(file);
      }

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        return data;
      } else {
        log("not add your review");
        if (kDebugMode) {
          debugPrint(responseBody);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future addReviewForDelivery({
    String? token,
    String? productId,
    String? rating,
    String? message,
    required List<File> files,
    // int? responses,
  }) async {
    try {
      //  var header = {
      //     "Accept": "application/json",
      //     "Authorization": "Bearer $token"
      //   };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$baseUrl/delivery-feedback',
        ),
      );
      request.headers['Authorization'] = 'Bearer ${AppStorage.readAccessToken}';
      request.fields['order_id'] = productId!;
      request.fields['rating'] = rating!;
      request.fields['message'] = message!;
      // request.fields['response'] = responses.toString();

      for (var i = 0; i < files.length; i++) {
        var file = await http.MultipartFile.fromPath('image[]', files[i].path);
        request.files.add(file);
      }

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        return data;
      } else {
        log("not add your review");
        if (kDebugMode) {
          debugPrint(responseBody);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future getCompletedOrder(token) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      debugPrint(header.toString());
      var response = await http.get(
        Uri.parse(
          '$baseUrl/view-completed-order',
        ),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'getCompletedOrder Error');
    }
  }

  Future returnOrderProduct(
      token, id, itemCount, reason, comment, aggree) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "id": id,
        "no_of_item": itemCount,
        "reason": reason,
        "comment": comment,
        "aggree": aggree,
      };
      debugPrint("return oder is $body");
      var response = await http.post(
          Uri.parse(
            '$baseUrl/return-order',
          ),
          headers: header,
          body: body);
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    }
  }

  Future cancelReason(
    token,
    id,
  ) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      var response = await http.get(
        Uri.parse(
          '$baseUrl/cancel-reason?orderid=$id',
        ),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    }
  }

  Future returnOrder(
    token,
  ) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      var response = await http.get(
        Uri.parse(
          '$baseUrl/return-order-list',
        ),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("new return $data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'returnOrderProduct Error');
    }
  }

  Future esewaFundApply(
    token,
    name,
    contactNo,
    walletId,
    id,
  ) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "return_type": 'esewa',
        "name": name,
        "contact_no": contactNo,
        "wallet_id": walletId,
        "id": id,
      };
      var response = await http.post(
          Uri.parse(
            '$baseUrl/refund-apply',
          ),
          headers: header,
          body: body);
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'esewaFundApply Error');
    }
  }

  Future khaltiFundApply(
    token,
    id,
    name,
    contactNo,
    walletId,
  ) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "return_type": 'khalti',
        "name": name,
        "contact_no": contactNo,
        "wallet_id": walletId,
        "id": id,
      };
      var response = await http.post(
          Uri.parse(
            '$baseUrl/refund-apply',
          ),
          headers: header,
          body: body);
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'khaltiFundApply Error');
    }
  }

  Future bankFundApply(
    token,
    id,
    name,
    var paymentmethod,
    branch,
    accountno,
    contactNo,
    accountType,
  ) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "return_type": 'bank',
        "name": name,
        "payment_method": paymentmethod,
        "branch": branch,
        "acc_no": accountno,
        "contact_no": contactNo,
        "account_type": accountType,
        "id": id,
      };
      var response = await http.post(
          Uri.parse(
            '$baseUrl/refund-apply',
          ),
          headers: header,
          body: body);
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'bankFundApply Error');
    }
  }

  Future cashApplyRefund(
    token,
    id,
  ) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var body = {
        "id": id,
      };
      var response = await http.post(
          Uri.parse(
            '$baseUrl/refund-apply',
          ),
          headers: header,
          body: body);
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'cashApplyRefund Error');
    }
  }

  Future getOrderedRejectedReason(token, id) async {
    try {
      var header = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.get(
        Uri.parse(
          '$baseUrl/order-rejected-reason?orderId=$id',
        ),
        headers: header,
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Mukunda$data");
      }
      if (response.statusCode == 200) {
        return data;
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'getOrderedReason Error');
    }
  }
}

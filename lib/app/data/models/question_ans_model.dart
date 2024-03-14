/*
class QuestionAnswer {
  bool? error;
  List<QuestionAnswerData>? data;
  String? msg;

  QuestionAnswer({this.error, this.data, this.msg});

  QuestionAnswer.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <QuestionAnswerData>[];
      json['data'].forEach((v) {
        data!.add(QuestionAnswerData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class QuestionAnswerData {
  int? id;
  int? productId;
  int? userId;
  int? parentId;
  String? questionAnswer;
  int? status;
  String? createdAt;
  String? updatedAt;
  Answer? answer;

  QuestionAnswerData(
      {this.id,
      this.productId,
      this.userId,
      this.parentId,
      this.questionAnswer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.answer});

  QuestionAnswerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    questionAnswer = json['question_answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    answer = json['answer'] != null ? Answer.fromJson(json['answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['question_answer'] = questionAnswer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (answer != null) {
      data['answer'] = answer!.toJson();
    }
    return data;
  }
}

class Answer {
  int? id;
  int? productId;
  int? userId;
  int? parentId;
  String? questionAnswer;
  int? status;
  String? createdAt;
  String? updatedAt;

  Answer(
      {this.id,
      this.productId,
      this.userId,
      this.parentId,
      this.questionAnswer,
      this.status,
      this.createdAt,
      this.updatedAt});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    questionAnswer = json['question_answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['question_answer'] = questionAnswer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
*/

/*class QuestionAnswerModel {
  bool? error;
  List<QuestionAnswerData>? data;
  String? msg;

  QuestionAnswerModel({this.error, this.data, this.msg});

  QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <QuestionAnswerData>[];
      json['data'].forEach((v) {
        data!.add(QuestionAnswerData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class QuestionAnswerData {
  int? id;
  int? productId;
  int? userId;
  int? parentId;
  String? questionAnswer;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Answer? answer;

  QuestionAnswerData(
      {this.id,
      this.productId,
      this.userId,
      this.parentId,
      this.questionAnswer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.answer});

  QuestionAnswerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    questionAnswer = json['question_answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    answer = json['answer'] != null ? Answer.fromJson(json['answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['question_answer'] = questionAnswer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (answer != null) {
      data['answer'] = answer!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? company;
  String? agree;
  String? gender;
  String? country;
  String? area;
  int? memberId;
  String? province;
  String? district;
  String? zip;
  bool? status;
  String? photo;
  String? emailVerifiedAt;
  int? providerId;
  String? provider;
  String? avatar;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.company,
      this.agree,
      this.gender,
      this.country,
      this.area,
      this.memberId,
      this.province,
      this.district,
      this.zip,
      this.status,
      this.photo,
      this.emailVerifiedAt,
      this.providerId,
      this.provider,
      this.avatar,
      this.twoFactorSecret,
      this.twoFactorRecoveryCodes,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    company = json['company'];
    agree = json['agree'];
    gender = json['gender'];
    country = json['country'];
    area = json['area'];
    memberId = json['member_id'];
    province = json['province'];
    district = json['district'];
    zip = json['zip'];
    status = json['status'];
    photo = json['photo'];
    emailVerifiedAt = json['email_verified_at'];
    providerId = json['provider_id'];
    provider = json['provider'];
    avatar = json['avatar'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['company'] = company;
    data['agree'] = agree;
    data['gender'] = gender;
    data['country'] = country;
    data['area'] = area;
    data['member_id'] = memberId;
    data['province'] = province;
    data['district'] = district;
    data['zip'] = zip;
    data['status'] = status;
    data['photo'] = photo;
    data['email_verified_at'] = emailVerifiedAt;
    data['provider_id'] = providerId;
    data['provider'] = provider;
    data['avatar'] = avatar;
    data['two_factor_secret'] = twoFactorSecret;
    data['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Answer {
  int? id;
  int? productId;
  int? userId;
  int? parentId;
  String? questionAnswer;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  Answer(
      {this.id,
      this.productId,
      this.userId,
      this.parentId,
      this.questionAnswer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    questionAnswer = json['question_answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['question_answer'] = questionAnswer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}*/

class QuestionAnswerModel {
  bool? error;
  List<QuestionAnswerData>? data;
  String? msg;

  QuestionAnswerModel({this.error, this.data, this.msg});

  QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <QuestionAnswerData>[];
      json['data'].forEach((v) {
        data!.add(QuestionAnswerData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class QuestionAnswerData {
  int? id;
  int? productId;
  int? customerId;
  int? sellerId;
  int? parentId;
  String? questionAnswer;
  int? status;
  String? createdAt;
  String? updatedAt;
  AnswerUser? user;
  Answer? answer;

  QuestionAnswerData(
      {this.id,
      this.productId,
      this.customerId,
      this.sellerId,
      this.parentId,
      this.questionAnswer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.answer});

  QuestionAnswerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    sellerId = json['seller_id'];
    parentId = json['parent_id'];
    questionAnswer = json['question_answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? AnswerUser.fromJson(json['user']) : null;
    answer = json['answer'] != null ? Answer.fromJson(json['answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['seller_id'] = sellerId;
    data['parent_id'] = parentId;
    data['question_answer'] = questionAnswer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (answer != null) {
      data['answer'] = answer!.toJson();
    }
    return data;
  }
}

class AnswerUser {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  dynamic status;
  String? photo;
  String? province;
  String? district;
  String? area;
  int? zip;
  String? companyName;
  String? verifyToken;
  int? verifyOtp;
  int? userId;
  String? emailVerifiedAt;
  String? socialProvider;
  String? providerId;
  String? createdAt;
  String? updatedAt;

  AnswerUser(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.status,
      this.photo,
      this.province,
      this.district,
      this.area,
      this.zip,
      this.companyName,
      this.verifyToken,
      this.verifyOtp,
      this.userId,
      this.emailVerifiedAt,
      this.socialProvider,
      this.providerId,
      this.createdAt,
      this.updatedAt});

  AnswerUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    photo = json['photo'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    zip = json['zip'];
    companyName = json['company_name'];
    verifyToken = json['verify_token'];
    verifyOtp = json['verify_otp'];
    userId = json['user_id'];
    emailVerifiedAt = json['email_verified_at'];
    socialProvider = json['social_provider'];
    providerId = json['provider_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    data['photo'] = photo;
    data['province'] = province;
    data['district'] = district;
    data['area'] = area;
    data['zip'] = zip;
    data['company_name'] = companyName;
    data['verify_token'] = verifyToken;
    data['verify_otp'] = verifyOtp;
    data['user_id'] = userId;
    data['email_verified_at'] = emailVerifiedAt;
    data['social_provider'] = socialProvider;
    data['provider_id'] = providerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Answer {
  int? id;
  int? productId;
  int? customerId;
  int? sellerId;
  int? parentId;
  String? questionAnswer;
  int? status;
  String? createdAt;
  String? updatedAt;
  AnswerUser? user;

  Answer(
      {this.id,
      this.productId,
      this.customerId,
      this.sellerId,
      this.parentId,
      this.questionAnswer,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    sellerId = json['seller_id'];
    parentId = json['parent_id'];
    questionAnswer = json['question_answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? AnswerUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['seller_id'] = sellerId;
    data['parent_id'] = parentId;
    data['question_answer'] = questionAnswer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  bool? status;
  String? photo;
  String? province;
  String? district;
  String? area;
  int? zip;
  String? companyName;
  String? verifyToken;
  int? verifyOtp;
  dynamic userId;
  String? emailVerifiedAt;
  String? socialProvider;
  String? providerId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.status,
      this.photo,
      this.province,
      this.district,
      this.area,
      this.zip,
      this.companyName,
      this.verifyToken,
      this.verifyOtp,
      this.userId,
      this.emailVerifiedAt,
      this.socialProvider,
      this.providerId,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    photo = json['photo'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    zip = json['zip'];
    companyName = json['company_name'];
    verifyToken = json['verify_token'];
    verifyOtp = json['verify_otp'];
    userId = json['user_id'];
    emailVerifiedAt = json['email_verified_at'];
    socialProvider = json['social_provider'];
    providerId = json['provider_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    data['photo'] = photo;
    data['province'] = province;
    data['district'] = district;
    data['area'] = area;
    data['zip'] = zip;
    data['company_name'] = companyName;
    data['verify_token'] = verifyToken;
    data['verify_otp'] = verifyOtp;
    data['user_id'] = userId;
    data['email_verified_at'] = emailVerifiedAt;
    data['social_provider'] = socialProvider;
    data['provider_id'] = providerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

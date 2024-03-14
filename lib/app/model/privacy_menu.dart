// To parse this JSON data, do
//
//     final privacyMenuModel = privacyMenuModelFromJson(jsonString);

import 'dart:convert';

PrivacyMenuModel privacyMenuModelFromJson(String str) => PrivacyMenuModel.fromJson(json.decode(str));

String privacyMenuModelToJson(PrivacyMenuModel data) => json.encode(data.toJson());

class PrivacyMenuModel {
    PrivacyMenuModel({
        this.error,
        this.data,
        this.msg,
    });

    bool? error;
    List<PrivacyMenuHeadingModel>? data;
    String? msg;

    factory PrivacyMenuModel.fromJson(Map<String, dynamic> json) => PrivacyMenuModel(
        error: json["error"],
        data: List<PrivacyMenuHeadingModel>.from(json["data"].map((x) => PrivacyMenuHeadingModel.fromJson(x))),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
    };
}

class PrivacyMenuHeadingModel {
    PrivacyMenuHeadingModel({
        this.id,
        this.name,
        this.slug,
        this.model,
        this.modelId,
        this.position,
        this.bannerImage,
        this.image,
        this.content,
        this.externalLink,
        this.status,
        this.metaTitle,
        this.metaKeywords,
        this.metaDescription,
        this.ogImage,
        this.lft,
        this.rgt,
        this.parentId,
        this.menuType,
        this.showOn,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? slug;
    String? model;
    int? modelId;
    int? position;
    String? bannerImage;
    String? image;
    String? content;
    dynamic externalLink;
    int? status;
    String? metaTitle;
    String? metaKeywords;
    String? metaDescription;
    String? ogImage;
    int? lft;
    int? rgt;
    int? parentId;
    String? menuType;
    String? showOn;
    dynamic deletedAt;
    String? createdAt;
    String? updatedAt;

    factory PrivacyMenuHeadingModel.fromJson(Map<String, dynamic> json) => PrivacyMenuHeadingModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        model: json["model"],
        modelId: json["model_id"],
        position: json["position"],
        bannerImage: json["banner_image"],
        image: json["image"],
        content: json["content"],
        externalLink: json["external_link"],
        status: json["status"],
        metaTitle: json["meta_title"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        ogImage: json["og_image"],
        lft: json["_lft"],
        rgt: json["_rgt"],
        parentId: json["parent_id"],
        menuType: json["menu_type"],
        showOn: json["show_on"],
        deletedAt: json["deleted_at"],
        createdAt:json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "model": model,
        "model_id": modelId,
        "position": position,
        "banner_image": bannerImage,
        "image": image,
        "content": content,
        "external_link": externalLink,
        "status": status,
        "meta_title": metaTitle,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "og_image": ogImage,
        "_lft": lft,
        "_rgt": rgt,
        "parent_id": parentId,
        "menu_type": menuType,
        "show_on": showOn,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class ParentCategoryModel {
  bool? error;
  List<Parent>? parent;
  String? msg;

  ParentCategoryModel({this.error, this.parent, this.msg});

  ParentCategoryModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['parent'] != null) {
      parent = <Parent>[];
      json['parent'].forEach((v) {
        parent!.add(Parent.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (parent != null) {
      data['parent'] = parent!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class Parent {
  int? id;
  String? title;
  String? slug;
  String? image;
  int? iLft;
  int? iRgt;
  int? parentId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Subcat>? subcat;

  Parent(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.iLft,
      this.iRgt,
      this.parentId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.subcat});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    iLft = json['_lft'];
    iRgt = json['_rgt'];
    parentId = json['parent_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcat'] != null) {
      subcat = <Subcat>[];
      json['subcat'].forEach((v) {
        subcat!.add(Subcat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['_lft'] = iLft;
    data['_rgt'] = iRgt;
    data['parent_id'] = parentId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subcat != null) {
      data['subcat'] = subcat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcat {
  int? id;
  String? title;
  String? slug;
  String? image;
  int? iLft;
  int? iRgt;
  int? parentId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Subcat(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.iLft,
      this.iRgt,
      this.parentId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Subcat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    iLft = json['_lft'];
    iRgt = json['_rgt'];
    parentId = json['parent_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['_lft'] = iLft;
    data['_rgt'] = iRgt;
    data['parent_id'] = parentId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

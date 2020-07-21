import 'package:mahkama/data/models/sub_category_model.dart';

class CategoryModel {
  String msg;
  String type;
  List data;

  CategoryModel({this.msg, this.type, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    type = json['type'].toString();
    if (json['data'] != null) {
      if (type.contains('two')) {
        data = new List<SubCatTypeTwo>();
        json['data'].forEach((v) {
          data.add(new SubCatTypeTwo.fromJson(v));
        });
      } else {
        data = new List<Category>();
        json['data'].forEach((v) {
          data.add(new Category.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  int categoryId;
  String createdAt;
  String updatedAt;

  Category(
      {this.id, this.name, this.categoryId, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

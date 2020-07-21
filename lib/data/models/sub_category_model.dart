class SubCategoryModel {
  String msg;
  String type;
  List data;

  SubCategoryModel({this.msg, this.type, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    type = json['type'].toString();
    if (json['data'] != null) {
      if (type.toLowerCase() == 'two') {
        data = new List<SubCatTypeTwo>();
        json['data'].forEach((v) {
          data.add(new SubCatTypeTwo.fromJson(v));
        });
      } else {
        data = new List<SubCategory>();
        json['data'].forEach((v) {
          data.add(new SubCategory.fromJson(v));
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

class SubCategory {
  int id;
  int subCategoryId;
  String nameOwner;
  String date;
  String name;
  String time;
  String address;
  num lng;
  num lat;
  String image;
  int sectionId;
  String section;
  int userId;
  int status;
  String createdAt;
  String updatedAt;

  SubCategory(
      {this.id,
      this.subCategoryId,
      this.nameOwner,
      this.date,
      this.time,
      this.address,
      this.lng,
      this.name,
      this.lat,
      this.image,
      this.sectionId,
      this.section,
      this.userId,
      this.status,
      this.createdAt,
      this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['sub_category'];
    subCategoryId = json['subCategory_id'];
    nameOwner = json['name_owner'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    lng = json['lng'];
    lat = json['lat'];
    image = json['image'];
    sectionId = json['section_id'];
    section = json['section'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['name_owner'] = this.nameOwner;
    data['date'] = this.date;
    data['time'] = this.time?.split(' ')?.first;
    data['lng'] = '${this.lng?? 0}';
    data['lat'] = '${this.lat?? 0}';
    data['address'] = this.address;
    data['img'] = this.image;
    data['section_id'] = this.sectionId.toString();
    data['subCategory_id'] = this.subCategoryId.toString();
    return data;
  }
}

class SubCatTypeTwo {
  int id;
  String name;
  String link;
  String text;
  String email;
  String phone1;
  String phone2;
  String categoryId;
  String subCategoryId;
  String createdAt;
  String updatedAt;

  SubCatTypeTwo(
      {this.id,
      this.name,
      this.link,
      this.text,
      this.email,
      this.phone1,
      this.phone2,
      this.categoryId,
      this.subCategoryId,
      this.createdAt,
      this.updatedAt});

  SubCatTypeTwo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    text = json['text'];
    email = json['email'];
    phone1 = json['phone1'].toString();
    phone2 = json['phone2'].toString();
    categoryId = json['category_id'].toString();
    subCategoryId = json['subCategory_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    data['text'] = this.text;
    data['email'] = this.email;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['category_id'] = this.categoryId;
    data['subCategory_id'] = this.subCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

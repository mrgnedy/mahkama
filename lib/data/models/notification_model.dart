import 'package:mahkama/data/models/sub_category_model.dart';

class NotificationModel {
  String msg;
  List<NotificationDetail> data;

  NotificationModel({this.msg, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<NotificationDetail>();
      json['data'].forEach((v) {
        data.add(new NotificationDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationDetail {
  int id;
  String title;
  String body;
  int type;
  int occasionId;
  int linkId;
  String createdAt;
  String updatedAt;
  SubCategory occasion;

  NotificationDetail(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.occasionId,
      this.linkId,
      this.createdAt,
      this.updatedAt,
      this.occasion});

  NotificationDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    occasionId = json['occasion_id'];
    linkId = json['link_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    occasion = json['occasion'] != null
        ? new SubCategory.fromJson(json['occasion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['occasion_id'] = this.occasionId;
    data['link_id'] = this.linkId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.occasion != null) {
      data['occasion'] = this.occasion.toJson();
    }
    return data;
  }
}


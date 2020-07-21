class SettingsModel {
  String msg;
  List<Setting> data;

  SettingsModel({this.msg, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Setting>();
      json['data'].forEach((v) {
        data.add(new Setting.fromJson(v));
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

class Setting {
  String splash1;
  String privacy;
  String conditions;
  String who;

  Setting({this.splash1, this.privacy, this.conditions, this.who});

  Setting.fromJson(Map<String, dynamic> json) {
    splash1 = json['splash–1'];
    privacy = json['Privacy'];
    conditions = json['conditions'];
    who = json['who'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['splash–1'] = this.splash1;
    data['Privacy'] = this.privacy;
    data['conditions'] = this.conditions;
    data['who'] = this.who;
    return data;
  }
}

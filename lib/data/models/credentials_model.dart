class CredentialModel {
  String msg;
  String apiToken;
  int code;
  Credentials data;

  CredentialModel({this.msg, this.apiToken, this.code, this.data});

  CredentialModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    apiToken = json['api_token'];
    code = json['code'];
    data = json['data'] != null ? new Credentials.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['api_token'] = this.apiToken;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Credentials {
  String firstName;
  String email;
  String lastName;
  int code;
  String sectionId;
  int type;
  String image;
  int isActive;
  String apiToken;
  String deviceToken;
  String updatedAt;
  String createdAt;
  String password;
  String confirmPassword;
  int id;

  Credentials(
      {this.firstName,
      this.email,
      this.password,
      this.confirmPassword,
      this.lastName,
      this.code,
      this.sectionId,
      this.type,
      this.image,
      this.isActive,
      this.apiToken,
      this.deviceToken,
      this.updatedAt,
      this.createdAt,
      this.id});

  Credentials.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
    code = json['code'];
    sectionId = json['section_id'].toString();
    type = json['type'];
    image = json['image'];
    isActive = json['is_active'];
    apiToken = json['api_token'];
    deviceToken = json['device_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['last_name'] = this.lastName;
    data['code'] = this.code;
    data['section_id'] = this.sectionId;
    data['type'] = this.type;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['api_token'] = this.apiToken;
    data['device_token'] = this.deviceToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
  Map<String, dynamic> register() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['section_id'] = this.sectionId;  
    data['device_token'] = '${this.deviceToken}';
    data['password'] = this.password;
    data['password confirmation'] = this.password;
    return data;
  }
  Map<String, dynamic> edit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['section_id'] = this.sectionId;
    return data;
  }
  Map<String, dynamic> login() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_token'] = '${this.deviceToken}';
    return data;
  }
}

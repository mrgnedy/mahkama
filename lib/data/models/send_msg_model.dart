class SendMsgModel {
  String name;
  String msg;

  SendMsgModel({this.name, this.msg});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['name'] = name;
    json['message'] = msg;
    return json;
  }
}

import 'package:http/http.dart';

class AddOccasionsModel {
  final String nameOwner;
  final String date;
  final String time;
  final String lat;
  final String lng;
  final String address;
  final String image;
  final String sectionID;
  final String subCategoryID;

  AddOccasionsModel(
    this.nameOwner,
    this.date,
    this.time,
    this.lat,
    this.lng,
    this.address,
    this.image,
    this.sectionID,
    this.subCategoryID,
  );

  Map<String, String> toJson(){
    Map<String, String> json = {};
    json['name_owner'] = nameOwner;
    json['date'] = date;
    json['time'] = time;
    json['lat'] = lat;
    json['lng'] = lng;
    json['address'] = address;
    json['img'] = image;
    json['section_id'] = sectionID;
    json['subCategory_id'] = subCategoryID;
    return json;
  }
}

import 'package:mahkama/core/api_utils.dart';
import 'package:mahkama/data/models/add_occasions.dart';
import 'package:mahkama/data/models/sub_category_model.dart';

class OccassionRepo {
  Future getHomeCategories() async {
    String url = APIs.homeEP;
    return await APIs.getRequest(url);
  }

  Future getCategoryByID(catID) async {
    String url = APIs.categoriesEP;
    Map<String, dynamic> body = {"category_id": '$catID'};
    return await APIs.postRequest(url, body);
  }

  Future getSubCategoryByID(subCatID) async {
    String url = APIs.subCategoryEP;
    Map<String, dynamic> body = {"subcategory_id": "$subCatID"};
    return await APIs.postRequest(url, body);
  }

  Future addOccasion(SubCategory addOccasion) async {
    String url = APIs.addoccasionEP;
    Map<String, String> body = addOccasion.toJson()..remove('img');
    return await APIs.postWithFile(url, body, filePath: addOccasion.image);
  }

  Future getInitialOccasions() async {
    String url = APIs.initialoccasionsEP;
    return await APIs.getRequest(url);
  }

  Future getFinishedOccasions() async {
    String url = APIs.finishoccasionsEP;
    return await APIs.getRequest(url);
  }

  Future finishOccasion(occasionID) async {
    String url = APIs.makeoccasionfinishEP;
    Map<String, dynamic> body = {'occasion_id': occasionID};
    return await APIs.postRequest(url, body);
  }

  Future getSections() async {
    String url = APIs.sectionsEP;
    return await APIs.getRequest(url);
  }
}

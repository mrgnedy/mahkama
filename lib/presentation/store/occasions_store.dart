import 'package:mahkama/data/models/category_model.dart';
import 'package:mahkama/data/models/sub_category_model.dart';
import 'package:mahkama/data/repos/occassions_repo.dart';

class OccassionsStore {
  final occassionRepo = OccassionRepo();
  String currentCatID;
  CategoryModel homeCategories;
  CategoryModel currentCategories;
  CategoryModel occassionTypes;
  CategoryModel sections;
  SubCategoryModel currentSubCategories;
  SubCategoryModel filteredOccassions;
  SubCategoryModel initialOccasions;
  SubCategoryModel finishedOccasions;
  SubCategory occassion = SubCategory();
  int secID;
  int currentPage;
  Future<CategoryModel> getHomeCategories() async {
    homeCategories = CategoryModel.fromJson(
      await occassionRepo.getHomeCategories(),
    );
    return homeCategories;
  }
  
  Future<CategoryModel> getCategoryByID([catID]) async {
    if (currentCatID == null) return currentCategories;
    currentCategories = null;
    currentCategories = CategoryModel.fromJson(
      await occassionRepo.getCategoryByID(catID ?? currentCatID),
    );
    if (currentCatID == '4') occassionTypes = currentCategories;
    currentCatID = null;
    return currentCategories;
  }

  Future<SubCategoryModel> getSubCategoryByID([catID]) async {
    if (currentCatID == null) return currentSubCategories;
    currentSubCategories = null;
    currentSubCategories =  SubCategoryModel.fromJson(
      await occassionRepo.getSubCategoryByID(catID ?? currentCatID),
    );
    print('HELO ${currentSubCategories?.data?.length}');
    currentCatID = null;
    return currentSubCategories;
  }

  Future<SubCategoryModel> getInitialOccasions() async {
    initialOccasions = SubCategoryModel.fromJson(
      await occassionRepo.getInitialOccasions(),
    );
    return initialOccasions;
  }

  Future<SubCategoryModel> getFinishedOccasions() async {
    finishedOccasions = SubCategoryModel.fromJson(
      await occassionRepo.getFinishedOccasions(),
    );
    return finishedOccasions;
  }

  Future addOccassion() async {
    return await occassionRepo.addOccasion(occassion);
  }

  Future<CategoryModel> getSections() async {
    sections = CategoryModel.fromJson(await occassionRepo.getSections());
    return sections;
  }
}

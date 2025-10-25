import 'package:alquilafacil/spaces/data/remote/helpers/local_categories_service_helper.dart';
import 'package:alquilafacil/spaces/domain/model/local_category.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LocalCategoriesProvider extends ChangeNotifier{
  final LocalCategoriesServiceHelper localCategoriesService;
  LocalCategoriesProvider(this.localCategoriesService);
  List<LocalCategory> localCategories = [];

  Future<void> getAllLocalCategories() async{
    try{
      localCategories = await localCategoriesService.getAllLocalCategories();
      Logger().i(localCategories);
    } catch (e){
      localCategories = [];
    }
    notifyListeners();
  }
}
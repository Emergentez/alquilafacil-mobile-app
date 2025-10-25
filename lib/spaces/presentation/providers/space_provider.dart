import 'dart:io';
import 'package:alquilafacil/spaces/data/remote/helpers/space_service_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/space.dart';

class SpaceProvider extends ChangeNotifier {
  final SpaceServiceHelper spaceService;
  List<Space> spaces = [];
  List<Space> currentSpaces = [];
  List<Space> favoriteSpaces = [];
  List<String> districts = [];
  List<String> expectDistricts = [];
  // Filter variables
  List<String> capacityRangesSelected = [];
  int minCapacityRangeSelected = 0;
  int maxCapacityRangeSelected = 0;
  int localCategoryIdSelected = 0;
  String address = "";
  Space? spaceSelected;
  List<String> spacePhotoUrls = [];
  bool isEditMode = false;


  var logger = Logger();

  // Local variables for updating space
  String currentLocalName = "";
  String currentDescription = "";
  String currentAddress = "";
  int currentPrice = 0;
  int currentCapacity = 0;
  String currentFeatures = "";

  SpaceProvider(this.spaceService) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    favoriteSpaces = [];

    for (var key in keys) {
      if (key.startsWith('favorite_') && prefs.getBool(key) == true) {
        final id = int.parse(key
            .split('_')
            .last);
        final space = await spaceService.getSpaceById(id);
        favoriteSpaces.add(space);
      }
      notifyListeners();
    }
  }

  Future<void> createSpace(Space space) async {
    try {
      await spaceService.createSpace(space);
    } catch (e) {
      logger.e(
          "Error while trying to create space, please check the service request",
          e);
    }
    notifyListeners();
  }

  Future<void> getAllSpaces() async {
    try {
      spaces = await spaceService.getAllSpaces();
    } catch (e) {
      spaces = [];
    }
    notifyListeners();
  }

  Future<void> fetchSpaceById(int id) async {
    spaceSelected = await spaceService.getSpaceById(id);
    notifyListeners();
  }

  Future<void> updateSpace() async {
    final spaceId = spaceSelected!.id;
    String localName = spaceSelected!.localName;
    String descriptionMessage = spaceSelected!.descriptionMessage;
    List<String> address;
    if (currentAddress.isNotEmpty) {
      address = currentAddress.split(",").map((part) => part.trim()).toList();
    } else {
      address = spaceSelected!.address.split(",").map((part) => part.trim()).toList();
    }
    int price = (spaceSelected!.price).toInt();
    int capacity = spaceSelected!.capacity;
    String features = spaceSelected!.features;

    Map<String, dynamic> space = {
      'localName': currentLocalName.isNotEmpty ? currentLocalName : localName,
      'descriptionMessage': currentDescription.isNotEmpty ? currentDescription : descriptionMessage,
      'country': address.isNotEmpty
          ? address[3]
          : spaceSelected!.address.split(",")[3],
      'city': address.isNotEmpty
          ? address[2]
          : spaceSelected!.address.split(",")[2],
      'district': address.isNotEmpty
          ? address[0]
          : spaceSelected!.address.split(",")[1],
      'street' : address.isNotEmpty
          ? address[1]
          : spaceSelected!.address.split(",")[0],
      'price': (currentPrice > 0 ? currentPrice : price).toInt(),
      'capacity': currentCapacity > 0 ? currentCapacity : capacity,
      'features': currentFeatures.isNotEmpty ? currentFeatures : features,
      'localCategoryId': spaceSelected!.localCategoryId,
      'userId': spaceSelected!.userId
    };
    try {
      await spaceService.updateSpace(spaceId, space);
    } catch (e) {
      logger.e(
          "Error while trying to update space, please check the service request",
          e);
    }
    spaceSelected = Space.fromMap(space);
    notifyListeners();
  }

  Future<void> searchDistrictsByCategoryIdAndRange() async {
    try {
      var districtsResponse =
      await spaceService.getAllSpacesByCategoryIdAndCapacityRange(
          localCategoryIdSelected, minCapacityRangeSelected, maxCapacityRangeSelected);
      currentSpaces = districtsResponse.toList();
    } catch (e) {
      logger.e(
          "Error while trying to fetch spaces districts, please check the service request");
    }
    notifyListeners();
  }

  Future<void> getAllDistricts() async {
    try {
      var districtsResponse = await spaceService.getAllDistricts();
      districts = districtsResponse.toList();
      logger.i("Districts: $districts");
    } catch (e) {
      logger.e(
          "Error while trying to fetch spaces districts, please check the service request");
    }
    notifyListeners();
  }

  Future<void> fetchMySpaces(int userId) async {
    try {
      currentSpaces = await spaceService.getSpacesByUserId(userId);
    } catch (e) {
      logger
          .e("Error while trying to fetch my spaces, please check the params");
    }
    notifyListeners();
  }

  bool isFavorite(int spaceId) {
    return favoriteSpaces.any((space) => space.id == spaceId);
  }

  Future<void> addFavorite(Space space) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_${space.id}', true);
    favoriteSpaces.add(space);
    notifyListeners();
  }

  Future<void> removeFavorite(Space space) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorite_${space.id}');
    favoriteSpaces.removeWhere((favSpace) => favSpace.id == space.id);
    notifyListeners();
  }

  void searchSpaceByName(String district) {
    currentSpaces = spaces
        .where((space) =>
        space.address.toLowerCase().contains(district.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void searchDistrict() {
    expectDistricts = districts
        .where((district) =>
        district.toLowerCase().contains(address.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void getFilterRanges() {
    var rangesCaught = spaceService.getFilterRanges(capacityRangesSelected);
    minCapacityRangeSelected = rangesCaught[0];
    maxCapacityRangeSelected = rangesCaught[1];
    notifyListeners();
  }

  void setSelectedSpace(Space currentSpaceSelected) {
    spaceSelected = currentSpaceSelected;
    notifyListeners();
  }

  void setIsEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  void setLocalName(String value) {
    currentLocalName = value;
    notifyListeners();
  }

  void setDescriptionMessage(String value) {
    currentDescription = value;
    notifyListeners();
  }

  void setAddress(String address) {
    currentAddress = address;
    notifyListeners();
  }

  void setCurrentPrice(int newPrice) {
    currentPrice = newPrice;
    notifyListeners();
  }

  void setCapacity(int value) {
    currentCapacity = value;
    notifyListeners();
  }

  void setFeatures(String newFeatures) {
    currentFeatures = newFeatures;
    notifyListeners();
  }

  Future<void> uploadImages(List<File> images) async {
    try {
      final urls = await spaceService.uploadImages(images);
      spacePhotoUrls.addAll(urls);
    } catch (e) {
      logger.e("Error uploading multiple images", e);
    }
    notifyListeners();
  }
}


import 'dart:collection';
import 'dart:io';

import 'package:alquilafacil/spaces/domain/model/space.dart';

abstract class SpaceService{
  Future<String> createSpace(Space space);
  Future<List<Space>> getAllSpaces();
  Future<Space> getSpaceById(int id);
  Future<Space> updateSpace(int spaceId, Map<String, dynamic> spaceToUpdate);
  Future<List<Space>> getAllSpacesByCategoryIdAndCapacityRange(int categoryId, int minRange, int maxRange);
  Future<HashSet<String>>  getAllDistricts();
  Future<List<Space>> getSpacesByUserId(int userId);
  Future<String> uploadImage(File image);
}
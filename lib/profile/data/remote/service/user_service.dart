import 'package:alquilafacil/profile/domain/model/profile.dart';

abstract class UserService {
  Future<String> getUsernameByUserId(int userId);
  Future<Profile> getProfileByUserId(int userId);
  Future<List<String>> getBankAccountsByUserId(int userId);
  Future<Profile> updateProfile(int id, Map<String, dynamic> profileToUpdate);
}
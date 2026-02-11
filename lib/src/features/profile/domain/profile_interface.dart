import 'package:van_life/src/features/profile/data/models/user_model.dart';

abstract class ProfileInterface {
  Future<UserModel> getUserInfo(String uid);
  Future<List<UserModel>> users(List<String> ids);
}

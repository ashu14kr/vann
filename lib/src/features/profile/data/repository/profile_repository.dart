import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_life/src/features/profile/data/models/user_model.dart';
import 'package:van_life/src/features/profile/domain/profile_interface.dart';

class ProfileRepository implements ProfileInterface {
  final FirebaseFirestore db;

  ProfileRepository({required this.db});

  @override
  Future<UserModel> getUserInfo(String uid) async {
    try {
      final result = await db.collection('users').doc(uid).get();
      final data = result.data();
      return UserModel.fromMap(data!);
    } catch (e) {
      throw Exception(e);
    }
  }
}

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

  @override
  Future<List<UserModel>> users(List<String> ids) async {
    if (ids.isEmpty) return [];

    try {
      // Firestore allows up to 30 IDs in a single 'whereIn' query
      final snapshots =
          await db
              .collection('users')
              .where(FieldPath.documentId, whereIn: ids)
              .get();

      return snapshots.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch users: $e");
    }
  }
}

import 'package:van_life/src/features/profile/data/models/user_model.dart';

class ProfilecontrollerModel {
  final bool isLoading;
  final UserModel userModel;
  final List<UserModel> users;
  final List<UserModel> chatUsers;

  ProfilecontrollerModel({
    required this.isLoading,
    required this.userModel,
    required this.users,
    required this.chatUsers,
  });

  factory ProfilecontrollerModel.intial() {
    return ProfilecontrollerModel(
      isLoading: true,
      userModel: UserModel(
        uid: "",
        displayName: "",
        email: "",
        isOnboarded: true,
        isVerified: false,
        verificationImageUrl: "",
        age: "",
        gender: "",
        travelType: "",
        interests: [],
        bio: "",
        currentCountry: "",
        visitedScratchMap: [],
        profileImages: [],
        vehicleImages: [],
        eventsHosted: [],
        eventsJoined: [],
        eventsSaved: [],
      ),
      users: [],
      chatUsers: [],
    );
  }

  ProfilecontrollerModel copyWith({
    bool? isLoading,
    UserModel? userModel,
    List<UserModel>? users,
    List<UserModel>? chatUsers,
  }) {
    return ProfilecontrollerModel(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
      users: users ?? this.users,
      chatUsers: chatUsers ?? this.chatUsers,
    );
  }
}

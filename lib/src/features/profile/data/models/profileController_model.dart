import 'package:van_life/src/features/profile/data/models/user_model.dart';

class ProfilecontrollerModel {
  final bool isLoading;
  final UserModel userModel;

  ProfilecontrollerModel({required this.isLoading, required this.userModel});

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
    );
  }

  ProfilecontrollerModel copyWith({bool? isLoading, UserModel? userModel}) {
    return ProfilecontrollerModel(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
    );
  }
}

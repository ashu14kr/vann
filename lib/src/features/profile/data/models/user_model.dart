class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final bool isOnboarded;
  final bool isVerified;
  final String verificationImageUrl;
  final String age;
  final String gender;
  final String travelType;
  final List<String> interests;
  final String bio;
  final String currentCountry;
  final List<String> visitedScratchMap;
  final List<String> profileImages;
  final List<String> vehicleImages;
  final List<String> eventsHosted;
  final List<String> eventsJoined;
  final List<String> eventsSaved;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.isOnboarded,
    required this.isVerified,
    required this.verificationImageUrl,
    required this.age,
    required this.gender,
    required this.travelType,
    required this.interests,
    required this.bio,
    required this.currentCountry,
    required this.visitedScratchMap,
    required this.profileImages,
    required this.vehicleImages,
    required this.eventsHosted,
    required this.eventsJoined,
    required this.eventsSaved,
  });

  // Convert Firestore Document to Dart Object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      isOnboarded: map['isOnboarded'] ?? false,
      isVerified: map['isVerified'] ?? false,
      verificationImageUrl: map['verificationImageUrl'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      travelType: map['travelType'] ?? '',
      interests: List<String>.from(map['interests'] ?? []),
      bio: map['bio'] ?? '',
      currentCountry: map['currentCountry'] ?? '',
      visitedScratchMap: List<String>.from(map['visitedScratchMap'] ?? []),
      profileImages: List<String>.from(map['profileImages'] ?? []),
      vehicleImages: List<String>.from(map['vehicleImages'] ?? []),
      eventsHosted: List<String>.from(map['eventsHosted'] ?? []),
      eventsJoined: List<String>.from(map['eventsJoined'] ?? []),
      eventsSaved: List<String>.from(map['eventsSaved'] ?? []),
    );
  }

  // Convert Dart Object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'isOnboarded': isOnboarded,
      'isVerified': isVerified,
      'verificationImageUrl': verificationImageUrl,
      'age': age,
      'gender': gender,
      'travelType': travelType,
      'interests': interests,
      'bio': bio,
      'currentCountry': currentCountry,
      'visitedScratchMap': visitedScratchMap,
      'profileImages': profileImages,
      'vehicleImages': vehicleImages,
      'eventsHosted': eventsHosted,
      'eventsJoined': eventsJoined,
      'eventsSaved': eventsSaved,
    };
  }
}

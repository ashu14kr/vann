class OnboardingStateModel {
  final String name;
  final String age;
  final String gender;
  final String travelType;
  final String userImage;
  final String verificationImage;
  final List<String> interests;

  OnboardingStateModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.interests,
    required this.travelType,
    required this.userImage,
    required this.verificationImage,
  });

  factory OnboardingStateModel.intial() {
    return OnboardingStateModel(
      name: "",
      age: "",
      gender: "Male",
      interests: [""],
      travelType: '',
      userImage: '',
      verificationImage: '',
    );
  }

  OnboardingStateModel copyWith({
    String? name,
    String? age,
    String? gender,
    String? travelType,
    String? userImage,
    String? verificationImage,
    List<String>? interests,
  }) {
    return OnboardingStateModel(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      interests: interests ?? this.interests,
      travelType: travelType ?? this.travelType,
      userImage: userImage ?? this.userImage,
      verificationImage: verificationImage ?? this.verificationImage,
    );
  }
}
